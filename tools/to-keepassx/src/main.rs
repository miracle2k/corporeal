extern crate encoding;
extern crate kpdb;
extern crate chrono;


mod pwstore;
mod delphi_date;

use std::fs::File;
use std::env;
use std::io;
use std::io::Write;
use std::io::BufReader;
use std::path::Path;
use pwstore::{PWStore};
use chrono::{DateTime, Utc, TimeZone};
use kpdb::{CompositeKey, Database, Entry};
use kpdb::Times;


fn main() {
    let filename = env::args().nth(1).expect("First argument needs to be filename of unencrypted Corporeal database.");

    let file = File::open(&filename).expect("Unable to open the given file.");
    let reader = BufReader::new(file);
    let store = PWStore::load(reader).expect("Failed to load the corporeal store.");    

    print_store_contents(&store);

    let output_filename = Path::new(&filename).with_extension("kdbx");

    println!("");
    print!("Password for the new store: ");
    io::stdout().flush().unwrap();
    let mut output_password = String::new();
    io::stdin().read_line(&mut output_password).unwrap();

    create_kpdb(store, output_filename.to_str().unwrap(), &output_password.trim());
}


fn print_store_contents(store: &PWStore) {
    let len = store.len();
    for index in 0..len {
        let item = store.get_item(index);
        println!("{} - {}", item.title, item.creation_time);
    }
}


fn create_kpdb(store: PWStore, filename: &str, password: &str) {
    let key = CompositeKey::from_password(password);
    let mut db = Database::new(&key);

    // let mut email_group = Group::new("Email");
    // let email_group_uuid = email_group.uuid;

    let len = store.len();
    for index in 0..len {
        let item = store.get_item(index);
        let mut entry = Entry::new();
        entry.set_title(item.title.as_str());
        entry.set_username(item.username.as_str());
        entry.set_password(item.password.as_str());
        entry.set_url(item.url.as_str());
        entry.set_notes(item.notes.as_str());
        let utc: DateTime<Utc> = Utc.timestamp(item.creation_time as i64, 0);
        entry.set_creation_time(utc);
        db.root_group.add_entry(entry);
    }
    //db.root_group.add_group(email_group);

    let mut file = File::create(filename).unwrap();
    db.save(&mut file).unwrap();
    println!("Written to: {}", filename);
}
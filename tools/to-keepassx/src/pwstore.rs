extern crate byteorder;

use encoding::{Encoding, DecoderTrap};
use encoding::all::ISO_8859_1;
use std::error::Error;
use std::io::Read;
use delphi_date::*;
use self::byteorder::{LittleEndian, ReadBytesExt};


const PWDB_HEADER: &'static str = "PWDB";
const PWDB_VERSION: i32 = 1;


pub struct PWItem {
    pub id: Option<u64>,
    pub title: String,
    pub username: String,
    pub password: String,
    pub url: String,
    pub notes: String,
    pub creation_time: u64
}


pub struct PWStore {
    pub items: Vec<PWItem>,
    last_auto_id: u64,
}


impl PWStore {    
    pub fn empty() -> PWStore {
        PWStore { items: Vec::new(), last_auto_id: 0 }
    }

    pub fn load<T: Read>(mut reader: T) -> Result<PWStore, Box<Error>> {
        let mut store = PWStore::empty();
        
        // Read header first
        let prolog = read_string(&mut reader, 4)?;
        if prolog != PWDB_HEADER {
            return Err(From::from("Invalid header (might be wrong key)"))
        }

        // Read version
        let version = reader.read_i32::<LittleEndian>()?;
        if version != PWDB_VERSION {
            return Err(From::from("Invalid file version"))
        }

        // Read all items
        let num_items = reader.read_i32::<LittleEndian>()?;
        for _i in 0..num_items {            
            let item = PWItem {
                id: None,
                title: read_string(&mut reader, 0)?,
                username: read_string(&mut reader, 0)?,
                password: read_string(&mut reader, 0)?,
                url: read_string(&mut reader, 0)?,
                notes: read_string(&mut reader, 0)?,
                creation_time: delphi_datetime_to_unix_timestamp(reader.read_f64::<LittleEndian>()?)
            };
            store.add(item);
        }

        return Ok(store);
    }

    pub fn add(&mut self, mut item: PWItem) {
        // https://stackoverflow.com/questions/26593387/how-i-get-the-current-time-in-milliseconds
        item.id = Some(self.get_next_id());
        self.items.push(item);
    }

    pub fn len(&self) -> u64 {
        return self.items.len() as u64;
    }

    pub fn get_item(&self, index: u64) -> &PWItem {
        return self.items.get(index as usize).expect("Invalid index");
    }

    fn get_next_id(&mut self) -> u64 {
        self.last_auto_id = self.last_auto_id + 1;
        return self.last_auto_id;
    }
}


fn read_string<T: Read>(reader: &mut T, length: u32) -> Result<String, Box<Error>> {
    let mut buffer: Vec<u8>;

    if length == 0 {
        let byte = reader.read_i32::<LittleEndian>()?;
        buffer = vec![0u8; byte as usize];
        reader.read_exact(buffer.as_mut_slice())?;        
    } else {
        buffer = vec![0u8; length as usize];
        reader.read_exact(buffer.as_mut_slice())?;
        
    }

    let x: String = ISO_8859_1.decode(&buffer, DecoderTrap::Strict)?;
    //let x = String::from_utf8_lossy(&buffer).into_owned();
    //let x = String::from_utf8(buffer)?;

    return Ok(x);
}
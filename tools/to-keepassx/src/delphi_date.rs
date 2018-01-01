// = UnixTimestamp(01/10/1900)
// TDatetime starts at 1900, Unix starts at 1970.
const UNIX_EPOCH_AS_DATETIME: f64 = 25569.0;
const SECS_PER_DAY: f64 = 86400.0;


pub fn delphi_datetime_to_unix_timestamp(datetime: f64) -> u64 {
    ((datetime - UNIX_EPOCH_AS_DATETIME) * SECS_PER_DAY) as u64
}

pub fn unix_timestamp_to_delphi_datetime(timestamp: u64) -> f64 {
    // Delphi TDatetime is 8-byte double:
    // TDateTime := (UnixTimestamp / SecsPerDay) + UnixTimestamp(01/10/1970)
    ((timestamp as f64) / SECS_PER_DAY) + UNIX_EPOCH_AS_DATETIME
}
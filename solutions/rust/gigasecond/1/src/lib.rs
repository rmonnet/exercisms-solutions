use time::PrimitiveDateTime as DateTime;
use time::Duration as Duration;

// Returns a DateTime one billion seconds after start.
pub fn after(start: DateTime) -> DateTime {
    const gigaseconds: Duration = Duration::new(1_000_000_000, 0);
    if let Some(end) = start.checked_add(gigaseconds)  {
        end
    } else {
        panic!("didn't get a result")
    }
}

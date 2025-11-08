
const DAYS_OF_WEEK = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

// Computes the number of days in a month.
function daysInMonth(year, month) {
  
  // Months in Javascript start at 0.
  
  // february (28 or 29 depending of the year)
  if (month == 1) {
    // check if the year is bisextile
    return ((year %4 == 0) && ((year % 400 != 0) || (year % 100 ==0))) ? 29 : 28;
  }

  // 31 days month (January, March, May, July, August, October, December)
  return ([0, 2, 4, 6, 7, 9, 11].includes(month)) ? 31 : 30;
}

// Computes how many days forwards the dayOfWeek ('Sunday' to 'Saturday') lays from the numeric dayOfMonth.
function offset(year, month, dayOfMonth, dayOfWeek) {
  
  const date = new Date(year, month, dayOfMonth);
  let offset = DAYS_OF_WEEK.indexOf(dayOfWeek) - date.getDay();
  if (offset < 0) offset += 7;
  return offset;
}

// Returns the Date of a meetup based on the type ('first', 'second', 'third', 'fourth', 'last', and 'teenth')
// and the desired DayOfWeek.
export function meetup(year, month, type, dayOfWeek) {
  
  // adjust month to start at 0 (JS convention)
  month -= 1;

  switch (type) {
    case 'teenth':
      // find which dayOfWeek is the 13th of this month and adjust forward to match the specified dayOfWeek.
      return new Date(year, month, 13+offset(year, month, 13, dayOfWeek));
    case 'first':
      // find which day is the first day of the month and adjust forward to match the specified day parameter.
      return new Date(year, month, 1+offset(year, month, 1, dayOfWeek));
    case 'second':
      // find which day is the first day of the month and adjust forward to match the specified day parameter,
      // then skip by 7 days to get the second day of the month.
      return new Date(year, month, 8+offset(year, month, 1, dayOfWeek));
    case 'third':
      // find which day is the first day of the month and adjust forward to match the specified day parameter,
      // then skip by 14 days to get the third day of the month .
      return new Date(year, month, 15+offset(year, month, 1, dayOfWeek));
    case 'fourth':
      // find which day is the first day of the month and adjust forward to match the specified day parameter,
      // then skip by 21 days to get the third day of the month .
      return new Date(year, month, 22+offset(year, month, 1, dayOfWeek));
    case 'last':
      // find which day is the last day of the month, adjust backward to match the specified day parameter.
      let lastDay = daysInMonth(year, month);
      let lastOffset = offset(year, month, lastDay, dayOfWeek);
      // unless the offset is 0, we are now in the next month, back out a week
      if (lastOffset > 0) lastOffset -= 7;
      return new Date(year, month, lastDay+lastOffset);
    default:
      return "";
  }
};

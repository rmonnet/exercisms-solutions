
const DAYS = ['first', 'second', 'third', 'fourth', 'fifth', 'sixth', 'seventh', 'eighth',
                'ninth', 'tenth', 'eleventh', 'twelfth'];

const GIFTS = [
  'a Partridge in a Pear Tree',
  'two Turtle Doves',
  'three French Hens',
  'four Calling Birds',
  'five Gold Rings',
  'six Geese-a-Laying',
  'seven Swans-a-Swimming',
  'eight Maids-a-Milking',
  'nine Ladies Dancing',
  'ten Lords-a-Leaping',
  'eleven Pipers Piping',
  'twelve Drummers Drumming',
];

function verse(day) {

  let gifts = '';
  for (let i = day-1; i >= 0; i--) {
    if (i < day-1) {
      gifts += ', ';
      if (i == 0) gifts += 'and ';
    }
    gifts += GIFTS[i];
  }
  return `On the ${DAYS[day-1]} day of Christmas my true love gave to me: ${gifts}.\n`;
};

export function recite(fromDay, toDay=fromDay) {
  let verses = [];
  for (let day = fromDay; day <= toDay; day++) verses.push(verse(day));
  return verses.join('\n');
}

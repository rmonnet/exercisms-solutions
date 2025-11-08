// algorithm:
// The actual book titles don't matter what matters is how many books of the same title we have.
// 
// We will reduce the problem as a array of numbers, the number of books we have per title (called
// a ticket).
// We will present the array with the highest number first and remove zeros.
//
// So if we have 3 sets of 2 books with the same title and 2 sets of 1 book with the same title,
// we represent this with the ticket [2,2,2,1,1].
// If we have a set of 3 books with the same title and 2 sets of 1 books with the same title, we
// represent it as the ticket [3, 1, 1].
//
// When we compute the cost of a ticket, we look at the largest group we can build with the ticket
// (the size of the ticket since each element has at least one book). We compare the cost using this
// largest group rebate + the best cost for the rest of the books with the cost if we start with a
// smaller group (constraining the max group size to the next smallest size).
// 
// When we calculate the remaining ticket after we reserve a group of books, we always start by removing
// 1 book each of the highest sets. This ensure the largest possible remaining group out of the remaining
// group. (Example, if we want to take a group of 4 books from the ticket [2,2,2,1,1], by removing
// 1 book out of the four largest sets we get [1,1,1,0,1] which leaves us with a second 4-books group,
// if we add removed 1 book from some other sets we could have ended up with [2,1,1,0,0] which only
// leaves up with a 3-books group).

// costs and discounts
const BOOK_COST = 800;
const GROUP_COSTS = [
  0,
  BOOK_COST,
  (1 -0.05) * 2 * BOOK_COST,
  (1 -0.10) * 3 * BOOK_COST,
  (1 -0.20) * 4 * BOOK_COST,
  (1 -0.25) * 5 * BOOK_COST,
];

// sum the number of books in a ticket
const sum = (array) => array.reduce((acc, val) => acc+val, 0)

// Converts a list of books to a ticket (array of number of books of the same kind).
// Returns a set of number of books with the same title in decreasing order with
// each set having at least one book.
function ticket(books) {

  let ticket = [0, 0, 0, 0, 0];
  for (const book of books) ticket[book-1] += 1;
  return ticket.sort((a,b) => b-a).filter(x => x > 0);
}

// Takes a group of n different books from a ticket.
// if n is less that the number of sets in the ticket, remove books from the largest
// sets first.
// Returns a set of number of books with the same title in decreasing order with
// each set having at least one book.
function take(n, ticket) {

  let result = [...ticket];
  for (let i = 0; i < n; i++) result[i]--;
  return result.sort((a,b) => b-a).filter(x => x > 0);
}

// Computes the cost of a ticket, assuming the largest group we can form is constrained
// by the parameter largestGroup.
function ticketCost(ticket, largestGroup) {

  if (ticket.length < largestGroup) largestGroup = ticket.length;
  if (largestGroup < 2) return sum(ticket) * BOOK_COST;

  return Math.min(
    GROUP_COSTS[largestGroup] + ticketCost(take(largestGroup, ticket), largestGroup),
    ticketCost(ticket, largestGroup-1));
}

// Computes the best price we can get for a set of books based on the provided discounts.
export function cost(books) {
  return ticketCost(ticket(books), 5);
};
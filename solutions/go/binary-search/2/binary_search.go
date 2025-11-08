package binarysearch

import (
    "slices"
)

func SearchInts(list []int, key int) int {
	if len(list) == 0 {
		return -1
	}
	// Make sure the list is sorted
	slices.Sort(list)
	if key < list[0] || key > list[len(list)-1] {
		return -1
	}
	start := 0
	end := len(list) - 1
	for start <= end {
		middle := (end + start) / 2
		switch {
		case list[middle] == key:
			return middle
		case list[middle] < key:
			start = middle + 1
		case list[middle] > key:
			end = middle - 1
		}
	}
	return -1
}

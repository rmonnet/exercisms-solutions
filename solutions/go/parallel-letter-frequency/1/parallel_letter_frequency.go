package letter

import "sync"

// FreqMap records the frequency of each rune in a given text.
type FreqMap map[rune]int

// AddAll merges the content of the other map into the receiver map.
func (m FreqMap) AddAll(other FreqMap) {
	for k, v := range other {
		m[k] += v
	}
}

// Frequency counts the frequency of each rune in a given text and returns this
// data as a FreqMap.
func Frequency(text string) FreqMap {
	frequencies := FreqMap{}
	for _, r := range text {
		frequencies[r]++
	}
	return frequencies
}

// ConcurrentFrequency counts the frequency of each rune in the given strings,
// by making use of concurrency.
func ConcurrentFrequency(texts []string) FreqMap {
	res := FreqMap{}
	var wg sync.WaitGroup
	wg.Add(len(texts))
	ch := make(chan FreqMap)

	// Once all the goroutines are done, close the channel
	// to signal all inputs have been processed.
	go func() {
		wg.Wait()
		close(ch)
	}()

	// Spawn one coroutine per line of input text to compute letter frequencies.
	for _, text := range texts {
		go func(t string) {
			defer wg.Done()
			ch <- Frequency(t)
		}(text)
	}

	// Merge all the goroutine results.
	for m := range ch {
		res.AddAll(m)
	}
	return res
}

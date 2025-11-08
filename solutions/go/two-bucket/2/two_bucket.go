package twobucket

import (
	"errors"
	"slices"
)

type state struct {
	volume      [2]int
	capacity    [2]int
	nsteps      int
	firstBucket int
	history     [][2]int
}

func NewState(firstBucket, sizeOne, sizeTwo int) state {
	res := state{firstBucket: firstBucket, nsteps: 1, capacity: [2]int{sizeOne, sizeTwo}}
	res.volume[firstBucket] = res.capacity[firstBucket]
	return res
}

func (s state) isEmpty(b int) bool {
	return s.volume[b] == 0
}

func (s state) isFull(b int) bool {
	return s.volume[b] == s.capacity[b]
}

func (s state) fill(b int) state {
	s.nsteps++
	s.history = append(s.history, s.volume)
	s.volume[b] = s.capacity[b]
	return s
}

func (s state) empty(b int) state {
	s.nsteps++
	s.history = append(s.history, s.volume)
	s.volume[b] = 0
	return s
}

func (s state) pour(from, into int) state {
	s.nsteps++
	s.history = append(s.history, s.volume)
	take := s.capacity[into] - s.volume[into]
	if take > s.volume[from] {
		take = s.volume[from]
	}
	s.volume[from] -= take
	s.volume[into] += take
	return s
}

func (s state) isStepAllowed() bool {
	// Check that the initial bucket is not empty and the other bucket is not full.
	otherBucket := (s.firstBucket + 1) % 2
	if s.volume[s.firstBucket] == 0 && s.volume[otherBucket] == s.capacity[otherBucket] {
		return false
	}
	// Check for infinite cycles
	for _, pastVolume := range s.history {
		if pastVolume == s.volume {
			return false
		}
	}
	return true
}

func step(paths []state) []state {
	newPaths := []state{}
	for _, path := range paths {
		for i := 0; i < 2; i++ {
			// Empty action
			if !path.isEmpty(i) {
				newPath := path.empty(i)
				if newPath.isStepAllowed() {
					newPaths = append(newPaths, newPath)
				}
			}
			// Fill action
			if !path.isFull(i) {
				newPath := path.fill(i)
				if newPath.isStepAllowed() {
					newPaths = append(newPaths, newPath)
				}
			}
			// Pour action
			if !path.isEmpty(i) && !path.isFull((i+1)%2) {
				newPath := path.pour(i, (i+1)%2)
				if newPath.isStepAllowed() {
					newPaths = append(newPaths, newPath)
				}
			}
		}
	}
	return newPaths
}

func solution(paths []state, goal int) (state, int, bool) {
	for _, path := range paths {
		for i := 0; i < 2; i++ {
			if path.volume[i] == goal {
				return path, i, true
			}
		}
	}
	return state{}, 0, false
}

var names = [2]string{"one", "two"}

func Solve(sizeBucketOne, sizeBucketTwo, goalAmount int, startBucket string) (string, int, int, error) {

	if sizeBucketOne == 0 || sizeBucketTwo == 0 {
		return "", 0, 0, errors.New("invalid bucket size")
	}
	if goalAmount <= 0 {
		return "", 0, 0, errors.New("invalid goal amount")
	}

	startingBucket := slices.Index(names[:], startBucket)
	if startingBucket == -1 {
		return "", 0, 0, errors.New("invalid start bucket name")
	}

	paths := []state{NewState(startingBucket, sizeBucketOne, sizeBucketTwo)}
	for i := 0; i < 1000; i++ {
		if sol, bucket, ok := solution(paths, goalAmount); ok {
			return names[bucket], sol.nsteps, sol.volume[(bucket+1)%2], nil
		}
		paths = step(paths)
		if len(paths) == 0 {
			return "", 0, 0, errors.New("no solution found")
		}
	}
	return "", 0, 0, errors.New("max number iterations exceeded")
}

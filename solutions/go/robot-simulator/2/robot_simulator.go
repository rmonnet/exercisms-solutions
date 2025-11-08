package robot

import (
	"fmt"
)

// See defs.go for other definitions

// Step 1
const (
	N Dir = iota
	E
	S
	W
)

var dirNames = map[Dir]string{N: "North", E: "East", S: "South", W: "West"}
var rightTurns = map[Dir]Dir{N: E, E: S, S: W, W: N}
var leftTurns = map[Dir]Dir{N: W, W: S, S: E, E: N}
var steps = map[Dir]Pos{N: {0, 1}, E: {1, 0}, S: {0, -1}, W: {-1, 0}}
var cmdToActions = map[Command]Action{'A': Step, 'R': TurnRight, 'L': TurnLeft}

func add(a, b Pos) Pos {
	return Pos{Easting: a.Easting + b.Easting, Northing: a.Northing + b.Northing}
}

func Right() {
	Step1Robot.Dir = rightTurns[Step1Robot.Dir]
}

func Left() {
	Step1Robot.Dir = leftTurns[Step1Robot.Dir]
}

func Advance() {
	// Can't use the more compact logic here since Ste1Robot doesn't use Pos.
	switch Step1Robot.Dir {
	case N:
		Step1Robot.Y++
	case E:
		Step1Robot.X++
	case S:
		Step1Robot.Y--
	case W:
		Step1Robot.X--
	}
}

func (d Dir) String() string {
	return dirNames[d]
}

// Step 2

type Action int

const (
	Step Action = iota
	TurnRight
	TurnLeft
	Done // Only used for Action3
)

func StartRobot(commands chan Command, actions chan Action) {
	for command := range commands {
		if action, ok := cmdToActions[command]; ok {
			actions <- action
		}
	}
	close(actions)
}

func Room(extent Rect, robot Step2Robot, actions chan Action, report chan Step2Robot) {
	for action := range actions {
		switch action {
		case Step:
			newPos := add(robot.Pos, steps[robot.Dir])
			if isInRoom(newPos, extent) {
				robot.Pos = newPos
			}
		case TurnRight:
			robot.Dir = rightTurns[robot.Dir]
		case TurnLeft:
			robot.Dir = leftTurns[robot.Dir]
		}
	}
	report <- robot
}

func isInRoom(pos Pos, extent Rect) bool {
	return pos.Easting >= extent.Min.Easting && pos.Easting <= extent.Max.Easting &&
		pos.Northing >= extent.Min.Northing && pos.Northing <= extent.Max.Northing
}

// Step 3

type Action3 struct {
	name string
	cmd  Action
}

func StartRobot3(name, script string, actions chan Action3, log chan string) {
commandLoop:
	for _, command := range script {
		action, ok := cmdToActions[Command(command)]
		if ok {
			actions <- Action3{name, action}
		} else {
			log <- fmt.Sprintf("robot %s received a bad command '%c', discard it", name, command)
			break commandLoop
		}
	}
	// Can't close the actions channel when we are done since it is used by the other robots.
	// Use the Done Action instead.
	actions <- Action3{name, Done}
}

func Room3(extent Rect, robots []Step3Robot, actions chan Action3, rep chan []Step3Robot, log chan string) {
	// This is not obvious from the problem description but it looks like if we log an error,
	// we should terminate Room3.
	robotsInRoom := mapRobotToNames(robots, log)
	checkRobotsLocation(robots, extent, log)
	nActiveRobots := len(robots)
actionLoop:
	for action := range actions {
		robot, ok := robotsInRoom[action.name]
		if !ok {
			log <- fmt.Sprintf("received a command from an unknown robot %s", action.name)
			// Having an invalid robot terminates the simulation.
			break actionLoop
		}
		switch action.cmd {
		case Step:
			newPos := add(robot.Pos, steps[robot.Dir])
			if !isInRoom(newPos, extent) {
				log <- fmt.Sprintf("robot %s attempted to walk into %s wall", robot.Name, robot.Dir)
				break
			}
			otherName, ok := otherRobotAtPosition(newPos, robot.Name, robots)
			if ok {
				log <- fmt.Sprintf("robot %s attempted to go to position %v occupied by robot %s",
					robot.Name, newPos, otherName)
				break
			}
			robot.Pos = newPos
		case TurnRight:
			robot.Dir = rightTurns[robot.Dir]
		case TurnLeft:
			robot.Dir = leftTurns[robot.Dir]
		case Done:
			nActiveRobots--
			if nActiveRobots == 0 {
				break actionLoop
			}
		}
	}
	rep <- robots
}

func mapRobotToNames(robots []Step3Robot, log chan string) map[string]*Step3Robot {
	res := map[string]*Step3Robot{}
	for i, robot := range robots {
		if robot.Name == "" {
			log <- "robot has no name"
		}
		if _, ok := res[robot.Name]; ok {
			log <- fmt.Sprintf("duplicate robot name %s", robot.Name)
		}
		res[robot.Name] = &robots[i]
	}
	return res
}

func checkRobotsLocation(robots []Step3Robot, extent Rect, log chan string) {
	locs := map[Pos]string{}
	for _, robot := range robots {
		if !isInRoom(robot.Pos, extent) {
			log <- fmt.Sprintf("robot %s places outside of the room", robot.Name)
		}
		if otherName, ok := locs[robot.Pos]; ok {
			log <- fmt.Sprintf("%s and %s are placed at the same location", robot.Name, otherName)
		}
		locs[robot.Pos] = robot.Name
	}
}

func otherRobotAtPosition(position Pos, exceptName string, robots []Step3Robot) (string, bool) {
	for _, other := range robots {
		if other.Name == exceptName {
			continue
		}
		if other.Pos == position {
			return other.Name, true
		}
	}
	return "", false
}
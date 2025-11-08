// @ts-check

// helper function, clip a number between a min and max value
function clip(x, min, max) {
  if (x < min) x = min;
  if (x > max) x = max;
  return x;
}

/**
 * Defines a Size class to represent window and screen sizes.
*/
export class Size {
  
  constructor(width = 80, height = 60) {
    this.width = width;
    this.height = height;
  }
  
  resize(newWidth, newHeight) {
    this.width = newWidth;
    this.height = newHeight;
  }
}

/**
 * Defines a Position class to represent window and point positions.
 */
export class Position {
  
  constructor(x = 0, y = 0) {
    this.x = x;
    this.y = y;
  }
  
  move(newX, newY) {
    this.x = newX;
    this.y = newY;
  }
}

/**
 * Defines a ProgramWindow class to represent GUI windows.
*/
export class ProgramWindow {
  
  constructor() {
    this.screenSize = new Size(800, 600);
    this.size = new Size();
    this.position = new Position();
  }
  
  resize(newSize) {

    const maxWidth = this.screenSize.width - this.position.x;
    let newWidth = clip(newSize.width, 1, maxWidth);
    
    const maxHeight = this.screenSize.height - this.position.y;
    let newHeight = clip(newSize.height, 1, maxHeight);

    this.size.resize(newWidth, newHeight);
  }

  move(newPosition) {

    const maxX = this.screenSize.width - this.size.width;
    let newX = clip(newPosition.x, 0, maxX);

    const maxY = this.screenSize.height - this.size.height;
    let newY = clip(newPosition.y, 0, maxY);

    this.position.move(newX, newY);
  }
}

/**
 * Set the position and size of a window to the specified value: width=400, height=300,
 * x = 100, and y = 150.
 */
export function changeWindow(window) {

  // avoid clipping by moving the window to the origin first
  window.move(new Position(0, 0));

  // then resize and move without having to worry about clipping
  window.resize(new Size(400, 300));
  window.move(new Position(100, 150));

  return window;
}

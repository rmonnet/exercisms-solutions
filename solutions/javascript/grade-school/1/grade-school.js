
export class GradeSchool {

  constructor() {
    // storing a map of pair student/grade as the internal db.
    // There implies some work to generate the roster but it makes it trivial
    // when a student changes grade.
    this._db = new Map();
  }

  // Generate the roster as ab Object of grade/[students] pairs.
  // The student list in a grade should be sorted.
  // The internal roster should be protected from indirect manipulations.
  roster() {
    let result = {};
    for (const grade of new Set(this._db.values())) {
      result[grade] = this.grade(grade);
    }
    return result;
  }

  // Adds a student for the given grade.
  // If the student was in a different grade, it should be transferred to the new grade.
  add(student, grade) {
    this._db.set(student, grade);
  }

  // Generate a list of student in the given grade.
  // The student list should be sorted.
  // The internal roster should be protected from indirect manipulations.
  grade(grade) {
    let studentClass = [];
    for (const student of this._db.keys()) {
      if (this._db.get(student) === grade) studentClass.push(student)
    };
    return studentClass.sort();
  }
}

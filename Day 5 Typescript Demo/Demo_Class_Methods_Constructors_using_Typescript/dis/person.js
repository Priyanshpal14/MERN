export class Person {
    constructor(name, age) {
        this.institute = "ABC Institute"; // readonly property
        this.name = name;
        this.age = age;
    }
    display() {
        console.log(`Name: ${this.name}, Age: ${this.age}, Institute: ${this.institute}`);
    }
}
export class Student extends Person {
    constructor(name, age, skills) {
        super(name, age);
        this.skills = skills;
        Student.studentCount++;
    }
    display() {
        super.display();
        console.log(`Skills: ${this.skills.join(", ")}`);
    }
    addSkill(newSkill) {
        this.skills = [...this.skills, newSkill]; // spread operator to clone and add new skill
    }
    static getStudentCount() {
        return Student.studentCount;
    }
}
Student.studentCount = 0; // static counter
export class Instructor extends Person {
    constructor(name, age, subject, experience) {
        super(name, age);
        this.subject = subject;
        this.experience = experience;
    }
    teach() {
        console.log(`${this.subject} is being taught by ${this.constructor.name} with ${this.experience} years of experience.`);
    }
    display() {
        super.display();
        console.log(`Subject: ${this.subject}, Experience: ${this.experience} years`);
    }
}

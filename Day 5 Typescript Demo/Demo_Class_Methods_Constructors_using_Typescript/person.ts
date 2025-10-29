export class Person {
    readonly institute: string = "ABC Institute"; // readonly property
    private name: string;
    private age: number;

    constructor(name: string, age: number) {
        this.name = name;
        this.age = age;
    }

    display(): void {
        console.log(`Name: ${this.name}, Age: ${this.age}, Institute: ${this.institute}`);
    }
}

export class Student extends Person {
    public skills: string[]; // made public
    private static studentCount: number = 0; // static counter

    constructor(name: string, age: number, skills: string[]) {
        super(name, age);
        this.skills = skills;
        Student.studentCount++;
    }

    display(): void {
        super.display();
        console.log(`Skills: ${this.skills.join(", ")}`);
    }

    addSkill(newSkill: string): void {
        this.skills = [...this.skills, newSkill]; // spread operator to clone and add new skill
    }

    static getStudentCount(): number {
        return Student.studentCount;
    }
}

export class Instructor extends Person {
    private subject: string;
    private experience: number;

    constructor(name: string, age: number, subject: string, experience: number) {
        super(name, age);
        this.subject = subject;
        this.experience = experience;
    }

    teach(): void {
        console.log(`${this.subject} is being taught by ${this.constructor.name} with ${this.experience} years of experience.`);
    }

    display(): void {
        super.display();
        console.log(`Subject: ${this.subject}, Experience: ${this.experience} years`);
    }
}

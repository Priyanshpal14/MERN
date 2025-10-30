// main.ts file will help us in creating objects of Person and Student class and calling their methods

//Step 1: importing person and student class from person.ts file

import { Person, Student, Instructor } from "./person.js";

const outputDiv = document.getElementById("output") as HTMLElement;

function logToPage(text: string) {
  outputDiv.innerHTML += text + "<br>";
}

// Create Person
const p = new Person("Priyansh", 25);
p.display();
logToPage(`👤 Person: Priyansh, Age: 25, Institute: ${p.institute}`);

// Create Student
const s = new Student("Riya", 22, ["JavaScript", "TypeScript"]);
s.addSkill("React");
logToPage(`<br>🎓 Student: Riya, Age: 22`);
logToPage(`Skills: ${s.skills.join(", ")}`);
logToPage(`Total Students: ${Student.getStudentCount()}`);

// Create Instructor
const inst = new Instructor("Arun", 35, "Web Development", 10);
logToPage(`<br>👨‍🏫 Instructor: Arun`);
logToPage(`Subject: Web Development`);
logToPage(`Experience: 10 years`);

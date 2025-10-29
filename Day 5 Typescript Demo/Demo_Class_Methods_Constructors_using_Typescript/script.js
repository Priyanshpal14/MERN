import { Person, Student, Instructor } from "./person.js";

function showCard(title, lines) {
    const outputDiv = document.getElementById("output");
    if (outputDiv) {
        const card = document.createElement("div");
        card.className = "card";

        const heading = document.createElement("h3");
        heading.textContent = title;
        card.appendChild(heading);

        lines.forEach(text => {
            const p = document.createElement("p");
            p.textContent = text;
            card.appendChild(p);
        });

        outputDiv.appendChild(card);
    }
}

// Create Person instance
const p = new Person("Priyansh", 25);
p.display();
showCard("👤 Person Details", [
    `Name: Priyansh`,
    `Age: 25`,
    `Institute: ${p.institute}`
]);

// Create Student instance
const s = new Student("Riya", 22, ["JavaScript", "TypeScript"]);
s.display();
showCard("🎓 Student Details", [
    `Name: Riya`,
    `Age: 22`,
    `Skills: ${s.skills.join(", ")}`
]);

// Add a new skill using spread operator
s.addSkill("React");
showCard("✨ Updated Skills", [
    `Added new skill: React`,
    `Now Skills: ${s.skills.join(", ")}`
]);

// Check total number of students
showCard("📊 Student Stats", [
    `Total Students: ${Student.getStudentCount()}`
]);

// Create Instructor instance
const inst = new Instructor("Arun", 35, "Web Development", 10);
inst.display();
inst.teach();
showCard("🧑‍🏫 Instructor Details", [
    `Name: Arun`,
    `Subject: Web Development`,
    `Experience: 10 years`
]);

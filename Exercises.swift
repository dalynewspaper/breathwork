import SwiftUI

struct BreathingExercise: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let duration: Double
    let description: String
    let howItWorks: String
    let purpose: String
    let instructions: [String]

    static func ==(lhs: BreathingExercise, rhs: BreathingExercise) -> Bool {
        return lhs.id == rhs.id
    }
}

let exercises = [
    BreathingExercise(
        name: "Diaphragmatic Breathing",
        duration: 300,
        description: "Deep breathing through the diaphragm rather than shallow breathing through the chest.",
        howItWorks: "Diaphragmatic breathing involves deep breathing using the diaphragm rather than shallow breathing through the chest. This method ensures that your lungs fill with more air, improving oxygen exchange and calming the nervous system.",
        purpose: "This technique helps reduce stress, lower heart rate, and improve lung efficiency. It’s often used in yoga, meditation, and relaxation practices.",
        instructions: [
            "Sit or lie down in a comfortable position.",
            "Place one hand on your chest and the other on your abdomen.",
            "Inhale deeply through your nose for 4 seconds, allowing your abdomen to rise while keeping your chest relatively still.",
            "Exhale slowly through your mouth for 6 seconds, feeling your abdomen fall.",
            "Repeat for 5-10 minutes, aiming for about 6-10 breaths per minute."
        ]
    ),
    BreathingExercise(
        name: "4-7-8 Breathing",
        duration: 300,
        description: "Inhale through the nose for 4 seconds, hold the breath for 7 seconds, and exhale slowly through the mouth for 8 seconds.",
        howItWorks: "This technique involves a specific rhythm of inhaling, holding, and exhaling the breath. The extended hold and exhale phases help calm the nervous system and promote relaxation.",
        purpose: "It promotes relaxation, helps with anxiety, and can improve sleep. It acts as a natural tranquilizer for the nervous system.",
        instructions: [
            "Sit or lie down in a comfortable position.",
            "Close your eyes and inhale quietly through your nose for a count of 4 seconds.",
            "Hold your breath for a count of 7 seconds.",
            "Exhale completely through your mouth, making a whoosh sound, for a count of 8 seconds.",
            "Repeat this cycle 4 times initially, gradually working up to 8 cycles."
        ]
    ),
    BreathingExercise(
        name: "Box Breathing",
        duration: 240,
        description: "Inhale for 4 seconds, hold for 4 seconds, exhale for 4 seconds, hold for 4 seconds.",
        howItWorks: "Box breathing involves inhaling, holding the breath, exhaling, and holding again for equal lengths of time. This balanced breathing pattern helps stabilize and calm the mind.",
        purpose: "Used to calm the mind, reduce stress, and improve concentration. It’s often used by athletes and military personnel to stay focused under pressure.",
        instructions: [
            "Sit upright in a comfortable position.",
            "Inhale through your nose for 4 seconds.",
            "Hold your breath for 4 seconds.",
            "Exhale through your nose for 4 seconds.",
            "Hold your breath again for 4 seconds.",
            "Repeat for 4-5 minutes."
        ]
    ),
    BreathingExercise(
        name: "Alternate Nostril Breathing",
        duration: 300,
        description: "Close the right nostril and inhale through the left nostril, then close the left nostril and exhale through the right.",
        howItWorks: "This technique involves breathing in and out through alternate nostrils, which is believed to balance the flow of energy in the body and promote mental clarity.",
        purpose: "Balances the nervous system, improves respiratory function, and enhances mental clarity. It’s commonly practiced in yoga.",
        instructions: [
            "Sit comfortably with your spine straight.",
            "Close your right nostril with your right thumb and inhale deeply through your left nostril for 4 seconds.",
            "Close your left nostril with your right ring finger, release your right nostril, and exhale through your right nostril for 4 seconds.",
            "Inhale through your right nostril for 4 seconds.",
            "Close your right nostril again, release your left nostril, and exhale through your left nostril for 4 seconds.",
            "Repeat for 5-10 minutes."
        ]
    ),
    BreathingExercise(
        name: "Buteyko Breathing",
        duration: 300,
        description: "Focuses on breathing through the nose and reducing the overall breathing volume.",
        howItWorks: "Buteyko breathing focuses on reducing the overall breathing volume to increase carbon dioxide levels in the body, which can help normalize breathing patterns.",
        purpose: "Improves asthma symptoms, reduces hyperventilation, and enhances overall respiratory health.",
        instructions: [
            "Sit comfortably and breathe normally through your nose.",
            "Take a small breath in and a small breath out.",
            "Hold your breath for a few seconds until you feel a slight urge to breathe.",
            "Resume normal nasal breathing.",
            "Practice for 10-15 minutes, focusing on reducing your breathing volume and breathing lightly."
        ]
    ),
    BreathingExercise(
        name: "Pursed Lip Breathing",
        duration: 300,
        description: "Inhale through the nose and exhale slowly through pursed lips.",
        howItWorks: "This technique involves inhaling through the nose and exhaling slowly through pursed lips, which helps keep the airways open longer and improves oxygen exchange.",
        purpose: "Helps with shortness of breath and is beneficial for people with chronic obstructive pulmonary disease (COPD). It improves the efficiency of oxygen exchange.",
        instructions: [
            "Sit comfortably and relax your shoulders.",
            "Inhale through your nose for 2 seconds.",
            "Purse your lips as if you’re going to whistle.",
            "Exhale slowly and gently through your pursed lips for 4 seconds.",
            "Repeat for 5-10 minutes."
        ]
    )
]

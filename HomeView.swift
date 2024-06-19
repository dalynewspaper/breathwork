import SwiftUI

struct HomeView: View {
    @Binding var showHomeView: Bool
    @Binding var selectedExercise: BreathingExercise?
    @State private var showDetail = false
    @State private var selectedDetailExercise: BreathingExercise?
    
    let exercises = [
        BreathingExercise(name: "Diaphragmatic Breathing", duration: 300, description: "Deep breathing through the diaphragm rather than shallow breathing through the chest.", detailedDescription: "How it works: Diaphragmatic breathing involves deep breathing using the diaphragm rather than shallow breathing through the chest. This method ensures that your lungs fill with more air, improving oxygen exchange and calming the nervous system. Purpose: This technique helps reduce stress, lower heart rate, and improve lung efficiency. It’s often used in yoga, meditation, and relaxation practices. Instructions: 1. Sit or lie down in a comfortable position. 2. Place one hand on your chest and the other on your abdomen. 3. Inhale deeply through your nose for 4 seconds, allowing your abdomen to rise while keeping your chest relatively still. 4. Exhale slowly through your mouth for 6 seconds, feeling your abdomen fall. 5. Repeat for 5-10 minutes, aiming for about 6-10 breaths per minute."),
        
        BreathingExercise(name: "4-7-8 Breathing", duration: 300, description: "Inhale through the nose for 4 seconds, hold the breath for 7 seconds, and exhale slowly through the mouth for 8 seconds.", detailedDescription: "How it works: This technique involves a specific rhythm of inhaling, holding, and exhaling the breath. The extended hold and exhale phases help calm the nervous system and promote relaxation. Purpose: It promotes relaxation, helps with anxiety, and can improve sleep. It acts as a natural tranquilizer for the nervous system. Instructions: 1. Sit or lie down in a comfortable position. 2. Close your eyes and inhale quietly through your nose for a count of 4 seconds. 3. Hold your breath for a count of 7 seconds. 4. Exhale completely through your mouth, making a whoosh sound, for a count of 8 seconds. 5. Repeat this cycle 4 times initially, gradually working up to 8 cycles."),
        
        BreathingExercise(name: "Box Breathing", duration: 240, description: "Inhale for 4 seconds, hold for 4 seconds, exhale for 4 seconds, hold for 4 seconds.", detailedDescription: "How it works: Box breathing involves inhaling, holding the breath, exhaling, and holding again for equal lengths of time. This balanced breathing pattern helps stabilize and calm the mind. Purpose: Used to calm the mind, reduce stress, and improve concentration. It’s often used by athletes and military personnel to stay focused under pressure. Instructions: 1. Sit upright in a comfortable position. 2. Inhale through your nose for 4 seconds. 3. Hold your breath for 4 seconds. 4. Exhale through your nose for 4 seconds. 5. Hold your breath again for 4 seconds. 6. Repeat for 4-5 minutes."),
        
        BreathingExercise(name: "Alternate Nostril Breathing", duration: 300, description: "Close the right nostril and inhale through the left nostril, then close the left nostril and exhale through the right.", detailedDescription: "How it works: This technique involves breathing in and out through alternate nostrils, which is believed to balance the flow of energy in the body and promote mental clarity. Purpose: Balances the nervous system, improves respiratory function, and enhances mental clarity. It’s commonly practiced in yoga. Instructions: 1. Sit comfortably with your spine straight. 2. Close your right nostril with your right thumb and inhale deeply through your left nostril for 4 seconds. 3. Close your left nostril with your right ring finger, release your right nostril, and exhale through your right nostril for 4 seconds. 4. Inhale through your right nostril for 4 seconds. 5. Close your right nostril again, release your left nostril, and exhale through your left nostril for 4 seconds. 6. Repeat for 5-10 minutes."),
        
        BreathingExercise(name: "Buteyko Breathing", duration: 300, description: "Focuses on breathing through the nose and reducing the overall breathing volume.", detailedDescription: "How it works: Buteyko breathing focuses on reducing the overall breathing volume to increase carbon dioxide levels in the body, which can help normalize breathing patterns. Purpose: Improves asthma symptoms, reduces hyperventilation, and enhances overall respiratory health. Instructions: 1. Sit comfortably and breathe normally through your nose. 2. Take a small breath in and a small breath out. 3. Hold your breath for a few seconds until you feel a slight urge to breathe. 4. Resume normal nasal breathing. 5. Practice for 10-15 minutes, focusing on reducing your breathing volume and breathing lightly."),
        
        BreathingExercise(name: "Pursed Lip Breathing", duration: 300, description: "Inhale through the nose and exhale slowly through pursed lips.", detailedDescription: "How it works: This technique involves inhaling through the nose and exhaling slowly through pursed lips, which helps keep the airways open longer and improves oxygen exchange. Purpose: Helps with shortness of breath and is beneficial for people with chronic obstructive pulmonary disease (COPD). It improves the efficiency of oxygen exchange. Instructions: 1. Sit comfortably and relax your shoulders. 2. Inhale through your nose for 2 seconds. 3. Purse your lips as if you’re going to whistle. 4. Exhale slowly and gently through your pursed lips for 4 seconds. 5. Repeat for 5-10 minutes."),
        
        BreathingExercise(name: "Belly Breathing", duration: 300, description: "Involves deep inhalations that expand the abdomen.", detailedDescription: "How it works: Belly breathing involves deep inhalations that expand the abdomen, which helps engage the diaphragm and promote deeper, more efficient breathing. Purpose: Reduces stress, lowers blood pressure, and improves core stability. Instructions: 1. Sit or lie down in a comfortable position. 2. Place one hand on your chest and the other on your abdomen. 3. Inhale deeply through your nose for 4 seconds, feeling your abdomen rise. 4. Exhale slowly through your mouth for 6 seconds, feeling your abdomen fall. 5. Repeat for 5-10 minutes."),
        
        BreathingExercise(name: "Kapalabhati", duration: 300, description: "Involves short, powerful exhales and passive inhales.", detailedDescription: "How it works: Kapalabhati involves short, powerful exhales and passive inhales, which helps cleanse the respiratory system and invigorate the mind. Purpose: Cleanses the lungs, increases energy levels, and improves concentration. It’s often used in yoga to prepare for meditation. Instructions: 1. Sit comfortably with your spine straight. 2. Take a deep breath in through both nostrils. 3. Exhale sharply and quickly through your nose while pulling your navel in towards your spine. Passive inhalation follows. 4. Perform 20 rapid breaths, then take a deep breath and exhale slowly. 5. Repeat for 3 rounds, gradually increasing the count as you become more comfortable."),
        
        BreathingExercise(name: "Resonant or Coherent Breathing", duration: 300, description: "Involves maintaining a steady and slow breathing rate.", detailedDescription: "How it works: Resonant breathing involves maintaining a steady and slow breathing rate to promote balance and relaxation in the body. Purpose: Promotes relaxation and balances the autonomic nervous system. It’s used to reduce stress and improve cardiovascular health. Instructions: 1. Sit or lie down in a comfortable position. 2. Inhale slowly and deeply through your nose for 5 seconds. 3. Exhale slowly and completely through your nose for 5 seconds. 4. Continue this pattern for 10-20 minutes, aiming for about 5-6 breaths per minute.")
    ]
    
    var body: some View {
           GeometryReader { geometry in
               ZStack {
                   LinearGradient(
                       gradient: Gradient(colors: [Color.black, Color.blue]),
                       startPoint: .top,
                       endPoint: .bottom
                   )
                   .edgesIgnoringSafeArea(.all)

                   VStack(alignment: .leading) {
                       Spacer()

                       // Featured Breathing Exercise
                       VStack(alignment: .leading) {
                           Text(exercises[2].name)
                               .font(.system(size: 48)) // Increased font size
                               .fontWeight(.bold)
                               .foregroundColor(.white)
                           Text(exercises[2].description)
                               .font(.title3)
                               .foregroundColor(.white)
                               .lineLimit(3)
                               .truncationMode(.tail)
                               .padding(.top, 5)
                               .frame(maxWidth: geometry.size.width * 0.45, alignment: .leading) // Setting max width
                           HStack {
                               Button(action: {
                                   selectedExercise = exercises[2]
                                   showHomeView = false
                               }) {
                                   HStack {
                                       Text("Play")
                                   }
                               }
                               .buttonStyle(PlayButtonStyle())
                               .padding(.top, 10)

                               Button(action: {
                                   selectedDetailExercise = exercises[2]
                                   showDetail = true
                               }) {
                                   HStack {
                                       Text("More Info")
                                   }
                               }
                               .buttonStyle(MoreInfoButtonStyle())
                               .padding(.top, 10)
                           }
                       }
                       .padding()
                       .background(Color.black.opacity(0.7))
                       .cornerRadius(10)
                       .padding(.horizontal)
                       .padding(.bottom, 20)

                       // Other Breathing Exercises
                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack(spacing: 20) {
                               ForEach(exercises) { exercise in
                                   VStack(alignment: .leading) {
                                       Text(exercise.name)
                                           .font(.title2)
                                           .foregroundColor(.white)
                                       Text(exercise.description)
                                           .font(.body)
                                           .foregroundColor(.white)
                                           .lineLimit(2)
                                           .truncationMode(.tail)
                                           .padding(.top, 5)
                                           .frame(maxWidth: geometry.size.width * 0.45, alignment: .leading)
                                   }
                                   .padding()
                                   .background(Color.black.opacity(0.7))
                                   .cornerRadius(10)
                                   .frame(width: 300, height: 250)
                                   .scaleEffect(selectedDetailExercise == exercise ? 1.1 : 1.0)
                                   .onTapGesture {
                                       selectedDetailExercise = exercise
                                       showDetail = true
                                   }
                                   .animation(.spring())
                               }
                           }
                           .padding(.horizontal)
                       }
                       .padding(.bottom, 20)
                   }
                   .frame(maxHeight: .infinity, alignment: .bottomLeading)

                   if showDetail, let detailExercise = selectedDetailExercise {
                       ModalView(exercise: detailExercise, isPresented: $showDetail)
                           .transition(.move(edge: .bottom))
                           .animation(.spring())
                   }
               }
           }
       }
   }



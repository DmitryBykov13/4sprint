//import UIKit
//
//final class MovieQuizViewController: UIViewController {
//    // MARK: - Lifecycle
//    @IBOutlet private weak var imageView: UIImageView!
//    @IBOutlet private weak var textLabel: UILabel!
//    @IBOutlet private weak var counterLabel: UILabel!
//
//    private var currentQuestionIndex: Int = 0
//    private var correctAnswers: Int = 0
//
//    struct ViewModel{
//        let image: UIImage
//        let question: String
//        let questionNumber: String
//    }
//
//    struct QuizStepViewModel{
//        let image: UIImage
//        let question: String
//        let questionNumber: String
//    }
//
//    struct QuizResultsViewModel{
//        let title: String
//        let text: String
//        let buttonText: String
//    }
//
//    struct AnswerResultsViewModel{
//        let answer: Bool
//    }
//
//    struct QuizQuestion{
//        let image: String
//        let text: String
//        let correctAnswer: Bool
//    }
//
//    private let questions: [QuizQuestion] = [
//        QuizQuestion(
//                    image: "The Godfather",
//                    text: "Рейтинг этого фильма больше чем 6?",
//                    correctAnswer: true),
//                QuizQuestion(
//                    image: "The Dark Knight",
//                    text: "Рейтинг этого фильма больше чем 6?",
//                    correctAnswer: true),
//                QuizQuestion(
//                    image: "Kill Bill",
//                    text: "Рейтинг этого фильма больше чем 6?",
//                    correctAnswer: true),
//                QuizQuestion(
//                    image: "The Avengers",
//                    text: "Рейтинг этого фильма больше чем 6?",
//                    correctAnswer: true),
//                QuizQuestion(
//                    image: "Deadpool",
//                    text: "Рейтинг этого фильма больше чем 6?",
//                    correctAnswer: true),
//                QuizQuestion(
//                    image: "The Green Knight",
//                    text: "Рейтинг этого фильма больше чем 6?",
//                    correctAnswer: true),
//                QuizQuestion(
//                    image: "Old",
//                    text: "Рейтинг этого фильма больше чем 6?",
//                    correctAnswer: false),
//                QuizQuestion(
//                    image: "The Ice Age Adventures of Buck Wild",
//                    text: "Рейтинг этого фильма больше чем 6?",
//                    correctAnswer: false),
//                QuizQuestion(
//                    image: "Tesla",
//                    text: "Рейтинг этого фильма больше чем 6?",
//                    correctAnswer: false),
//                QuizQuestion(
//                    image: "Vivarium",
//                    text: "Рейтинг этого фильма больше чем 6?",
//                    correctAnswer: false)
//            ]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//
//    @IBAction private func yesButtonClicked(_ sender: Any) {
//
//    }
//    @IBAction private func noButtonClicked(_ sender: Any) {
//
//    }
//
////    let currentQuestion = questions(currentQuestionIndex)
//
//    private func show (quiz step: QuizStepViewModel){
//
//    }
//
//    private func showAnswerResult(isCorrect: Bool){
//
//        if isCorrect {
//            correctAnswers += 1
//        }
//
//        imageView.layer.masksToBounds = true
//        imageView.layer.borderWidth = 8
//        imageView.layer.cornerRadius = 20
//        imageView.layer.borderColor = isCorrect ? UIColor.green.cgColor : UIColor.red.cgColor
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                self.showNextQuestionOrResult()
//            }
//    }
//
//    private func showNextQuestionOrResult(){
//        if currentQuestionIndex == questions.count - 1 {
//                let text = "Ваш результат: \(correctAnswers) из 10"
//                let viewModel = QuizResultsViewModel(
//                    title: "Этот раунд окончен!",
//                    text: text,
//                    buttonText: "Сыграть ещё раз")
//                show(quiz: viewModel)
//        } else {
//            currentQuestionIndex += 1
//            let nextQuestion = questions[currentQuestionIndex]
//            let viewModel = convert(model: nextQuestion)
//
//            show(quiz: viewModel)
//
//        }
//    }
//
//    private func show (quiz result: QuizResultsViewModel){
//
//        let alert = UIAlertController(
//                title: result.title,
//                message: result.text,
//                preferredStyle: .alert)
//
//        self.correctAnswers = 0
//
//            let action = UIAlertAction(title: result.buttonText, style: .default) {_ in
//                self.currentQuestionIndex = 0
//
//                let firstQuestion = self.questions[self.currentQuestionIndex]
//                let viewModel = self.convert(model: firstQuestion)
//                self.show(quiz: viewModel)
//            }
//
//            alert.addAction(action)
//
//            self.present(alert, animated: true, completion: nil)
//    }
//
//    private func convert (model: QuizQuestion) -> QuizStepViewModel{
//        return QuizStepViewModel(image: UIImage(named: model.image) ?? UIImage(),
//                                 question: model.text,
//                                 questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)")
//    }
//}
//
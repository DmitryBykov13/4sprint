import UIKit

final class MovieQuizViewController: UIViewController {
    // MARK: - Lifecycle
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var yesButton: UIButton!
    
    private var currentQuestionIndex: Int = 0
    private var correctAnswers: Int = 0
    private var rightAnswerCount: Int = 0
    private var quizeCount: Int = 0
    private var totalRightAnswerCount: Int = 0
    private var answersRecord: Int = 0
    private var recordDate: Date = Date()
    
    struct ViewModel{
        let image: UIImage
        let question: String
        let questionNumber: String
    }
    
    struct QuizStepViewModel{
        let image: UIImage
        let question: String
        let questionNumber: String
    }

    struct QuizResultsViewModel{
        let title: String
        let text: String
        let buttonText: String
    }

    struct QuizQuestion{
        let image: String
        let text: String
        let correctAnswer: Bool
    }

    private let questions: [QuizQuestion] = [
        QuizQuestion(
                    image: "The Godfather",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: true),
                QuizQuestion(
                    image: "The Dark Knight",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: true),
                QuizQuestion(
                    image: "Kill Bill",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: true),
                QuizQuestion(
                    image: "The Avengers",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: true),
                QuizQuestion(
                    image: "Deadpool",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: true),
                QuizQuestion(
                    image: "The Green Knight",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: true),
                QuizQuestion(
                    image: "Old",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: false),
                QuizQuestion(
                    image: "The Ice Age Adventures of Buck Wild",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: false),
                QuizQuestion(
                    image: "Tesla",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: false),
                QuizQuestion(
                    image: "Vivarium",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: false)
            ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yesButton.layer.cornerRadius = 15
        noButton.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        showStep(quize: createStepModel(model: questions[currentQuestionIndex]))
    }

    @IBAction private func yesButtonClicked(_ sender: Any) {
        showAnswerResult(isCorrect: questions[currentQuestionIndex].correctAnswer)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.showNextQuestionOrResult()
        }
    }
    @IBAction private func noButtonClicked(_ sender: Any) {
        showAnswerResult(isCorrect: !questions[currentQuestionIndex].correctAnswer)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.showNextQuestionOrResult()
        }
    }
    
    private func showAnswerResult(isCorrect: Bool){
        noButton.isUserInteractionEnabled = false
        yesButton.isUserInteractionEnabled = false
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.green.cgColor : UIColor.red.cgColor
        if isCorrect {
            rightAnswerCount += 1
        }
    }
    
    private func showNextQuestionOrResult(){
        imageView.layer.borderWidth = 0
        imageView.layer.borderColor = UIColor.white.withAlphaComponent(0.0).cgColor
        if currentQuestionIndex == questions.count - 1 {
            if quizeCount == 0 || rightAnswerCount > answersRecord{
                answersRecord = rightAnswerCount
                recordDate = Date()
            }
        totalRightAnswerCount += self.rightAnswerCount
                quizeCount += 1
                showResult(quize: QuizResultsViewModel(
                    title: "Этот раунд окончен",
                    text: getResultMessage(),
                    buttonText: "Сыграть еще раз"
            )
            )
        } else {
            currentQuestionIndex += 1
            showStep(quize: createStepModel(model: questions[currentQuestionIndex]))
        }
    }

    private func showStep(quize step: QuizStepViewModel) {
        noButton.isUserInteractionEnabled = true
        yesButton.isUserInteractionEnabled = true
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }

    private func show (quiz result: QuizResultsViewModel){
        noButton.isUserInteractionEnabled = false
        yesButton.isUserInteractionEnabled = false
        let alert = UIAlertController(
                title: result.title,
                message: result.text,
                preferredStyle: .alert)
        let action = UIAlertAction(
                title: result.buttonText,
                style: .default, handler: {_ in
                self.currentQuestionIndex = 0
                self.rightAnswerCount = 0
                self.showStep(quize: self.createStepModel(model: self.questions[0]))
            })
        
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
    }
    
    private func createStepModel(model: QuizQuestion) -> QuizStepViewModel {
        return QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)"
        )
    }
    
    private func showResult(quize result: QuizResultsViewModel) {
        noButton.isUserInteractionEnabled = false
        yesButton.isUserInteractionEnabled = false
        let alert = UIAlertController(
            title: result.title,
            message: result.text,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: result.buttonText,
            style: .default, handler: {_ in
            self.currentQuestionIndex = 0
            self.rightAnswerCount = 0
            self.showStep(quize: self.createStepModel(model: self.questions[0]))
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func getResultMessage() -> String {
        let formater = DateFormatter()
        formater.dateFormat = "dd.MM.yyyy hh:mm"
        let result: String = "Ваш результат: \(rightAnswerCount)/\(questions.count)."
        let quize: String = "Количество сыгранных квизов: \(quizeCount)."
        let record: String = "Рекорд: \(answersRecord)/\(questions.count) (\(formater.string(from: recordDate)))."
        let percent = (Double(totalRightAnswerCount) / Double(quizeCount * questions.count) * 10000).rounded() / 100
        let statistic: String = "Средняя точность: \(percent)%."
        return result + "\n" + quize + "\n" + record + "\n" + statistic
    }
    
    private func convert (model: QuizQuestion) -> QuizStepViewModel{
        return QuizStepViewModel(image: UIImage(named: model.image) ?? UIImage(),
                                 question: model.text,
                                 questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)")
    }
}

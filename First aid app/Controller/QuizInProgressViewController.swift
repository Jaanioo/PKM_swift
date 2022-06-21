//
//  QuizInProgressViewController.swift
//  First aid app
//
//  Created by Jan Paleń on 02/06/2022.
//

import UIKit

class QuizInProgressViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet weak var switchOne: UISwitch!
    @IBOutlet weak var switchTwo: UISwitch!
    @IBOutlet weak var switchThree: UISwitch!
    @IBOutlet weak var switchFour: UISwitch!
    
    @IBOutlet weak var questionLabelOne: UILabel!
    @IBOutlet weak var questionLabelTwo: UILabel!
    @IBOutlet weak var questionLabelThree: UILabel!
    @IBOutlet weak var questionLabelFour: UILabel!
    
    var questions = [Question]()
    var currentQuestion: Question?
    
    var questionIndex = 0
    
    var points = 0
    var quizTypeInt = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setupQuestions()
        updateUI()
    }
    
    func updateUI() {
        
        navigationItem.title = "Pytanie \(questionIndex + 1)"
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = (Float(questionIndex) + 1) / Float(questions.count)
        
        questionLabel.text = currentQuestion.text
        progressBar.setProgress(totalProgress, animated: true)
        
        updateQuestion(using: currentAnswers)
        print(points)
    }
    
    func updateQuestion (using answers: [Answer]) {
        
        switchOne.isOn = false
        switchTwo.isOn = false
        switchThree.isOn = false
        switchFour.isOn = false
        
        questionLabelOne.text = answers[0].text
        questionLabelTwo.text = answers[1].text
        questionLabelThree.text = answers[2].text
        questionLabelFour.text = answers[3].text
    }
    
    @IBAction func submitAnswerButtonPressed(_ sender: UIButton) {
        
        let currentAnswer = questions[questionIndex].answers
        
        if switchOne.isOn && currentAnswer[0].correct == true {
            points += 1
        } else if switchTwo.isOn && currentAnswer[1].correct == true {
            points += 1
        } else if switchThree.isOn && currentAnswer[2].correct == true {
            points += 1
        } else if switchFour.isOn && currentAnswer[3].correct == true{
            points += 1
        }
        
        nextQuestion()
    }
    
    @IBAction func switchOnePressed(_ sender: UISwitch) {
        if self.switchOne.isOn {
            self.switchTwo.isOn = false
            self.switchThree.isOn = false
            self.switchFour.isOn = false
        }
    }

    @IBAction func switchTwoPressed(_ sender: UISwitch) {
        if self.switchTwo.isOn {
            self.switchOne.isOn = false
            self.switchThree.isOn = false
            self.switchFour.isOn = false
        }
    }

    @IBAction func switchThreePressed(_ sender: UISwitch) {
        if self.switchThree.isOn {
            self.switchOne.isOn = false
            self.switchTwo.isOn = false
            self.switchFour.isOn = false
        }
    }

    @IBAction func switchFourPressed(_ sender: UISwitch) {
        if self.switchFour.isOn {
            self.switchOne.isOn = false
            self.switchTwo.isOn = false
            self.switchThree.isOn = false
        }
    }
    
    func nextQuestion() {
        
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ShowResults", sender: nil)
        }
    }
    
    //MARK: - moving to popup viewcontroller with result
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowResults" {
            
            let quizResultsViewController = segue.destination as! QuizResultsViewController
            quizResultsViewController.points = self.points
            quizResultsViewController.numberOfQuestions = self.questions.count
        }
    }
    
    //MARK: - Setting up questions for every quiz
    private func setupQuestions() {
        
        switch quizTypeInt {
            
        case 1:
            questions.append(Question(text: "Co należy zrobić w przypadku podejrzenia zwichnięcia stawu kolanowego?", answers: [
            Answer(text: "Rozmasować staw.", correct: false),
            Answer(text: "Nakazać poszkodowanemu \nwykonywanie delikatnych ruchów uszkodzoną kończyną.", correct: false),
            Answer(text: "Unieruchomić staw w pozycji fizjologicznej (prawidłowej).", correct: false),
            Answer(text: "Unieruchomić staw kolanowy w pozycji zastanej.", correct: true)
        ]))
        
        questions.append(Question(text: "Które kości są najbardziej narażone na złamania?", answers: [
            Answer(text: "Strzemiączko.", correct: false),
            Answer(text: "Obojczyk.", correct: false),
            Answer(text: "Miednica.", correct: false),
            Answer(text: "Strzałkowa.", correct: true)
        ]))
        
        questions.append(Question(text: "Zwichnięcie to:", answers: [
            Answer(text: "Wzajemne przemieszczenie się \nwzględem siebie powierzchni stawowych kości.", correct: true),
            Answer(text: "Zamknięte uszkodzenie \nwewnętrznej struktury tkanki.", correct: false),
            Answer(text: "Przerwanie ciągłości tkanki kostnej.", correct: false),
            Answer(text: "Przerwanie naczynia tętniczego lub krwionośnego.", correct: false)
        ]))
        
        questions.append(Question(text: "Które z wymienionych objawów nie są objawami złamania?", answers: [
            Answer(text: "Pełna ruchomość kończyny.", correct: true),
            Answer(text: "Ograniczona ruchomość kończyny.", correct: false),
            Answer(text: "Ból nasilający się przy ruchu.", correct: false),
            Answer(text: "Nienaturalne ułożenie kończyny.", correct: false)
        ]))
        
        questions.append(Question(text: "Co jest pierwszym objawem skręcenia?", answers: [
            Answer(text: "Pełna ruchomość kończyny.", correct: false),
            Answer(text: "Ból.", correct: true),
            Answer(text: "Krwiak.", correct: false),
            Answer(text: "Obrzęk.", correct: false)
        ]))
        
        questions.append(Question(text: "Prostym i skutecznym sposobem unieruchomienia kończyny dolnej jest:", answers: [
            Answer(text: "Przymocowanie jej do \nkończyny zdrowej.", correct: true),
            Answer(text: "Założenie chusty trójkątnej.", correct: false),
            Answer(text: "Wyprostowanie uszkodzonych \nkończyn i zabandażowanie.", correct: false),
            Answer(text: "Żadne z powyższych.", correct: false)
        ]))
        
        questions.append(Question(text: "Przy zwichnięciu lub skręceniu należy unieruchomić:", answers: [
            Answer(text: "Tylko uszkodzony staw.", correct: false),
            Answer(text: "Uszkodzony staw wraz z dwiema sąsiadującymi kośćm.", correct: true),
            Answer(text: "Kość i dwa sąsiednie stawy.", correct: false),
            Answer(text: "Żadne z powyższych.", correct: false)
        ]))
        
        questions.append(Question(text: "Urazy kręgosłupa należy podejrzewać przy:", answers: [
            Answer(text: "Wypadkach komunikacyjnych.", correct: false),
            Answer(text: "Upadku z dużej wysokości.", correct: false),
            Answer(text: "Skokach do wody na główkę", correct: false),
            Answer(text: "Wszystkie odpowiedzi są poprawne.", correct: true)
        ]))
        
        questions.append(Question(text: "Chłopiec po upadku z drabiny z wysokości 3 m leży na ziemi i jęczy. Co należy zrobić w pierwszej kolejności:", answers: [
            Answer(text: "Odciągnąć go w bezpieczne \nmiejsce.", correct: false),
            Answer(text: "Próbować postawić na nogi.", correct: false),
            Answer(text: "Nie ruszać do czasu przybycia \nzespołu ratowniczego.", correct: true),
            Answer(text: "Podać środek p/bólowy w tabletce.", correct: false)
        ]))
        
        questions.append(Question(text: "W przypadku obrażeń kości i stawów możemy zmniejszyć obrzęk w następujący sposób:", answers: [
            Answer(text: "Bandażując opatrunkiem \nelastycznym.", correct: false),
            Answer(text: "Stosując ciepły kompres.", correct: false),
            Answer(text: "Stosując zimny okład.", correct: true),
            Answer(text: "Polewając wodą przez 10 minut.", correct: false)
        ]))
        
        questions.append(Question(text: "Przy podejrzeniu złamania kończyny należy:", answers: [
            Answer(text: "Nastawić kości w osi kończyny.", correct: false),
            Answer(text: "Podać doustnie lek p/bólowy o silnym działaniu.", correct: false),
            Answer(text: "Unieruchomić w zastanej pozycji.", correct: true),
            Answer(text: "Obandażować kończynę w celu zmniejszenia obrzęku.", correct: false)
        ]))
        
        questions.append(Question(text: "Typowy objawurazu kręgosłupa to:", answers: [
            Answer(text: "Obrzęk w okolicy uszkodzenia.", correct: false),
            Answer(text: "Mimowolne oddawanie moczu i kału.", correct: true),
            Answer(text: "Sińce lub krwiaki w okolicy \nuszkodzenia.", correct: false),
            Answer(text: "Wszystkie odpowiedzi są poprawne.", correct: false)
        ]))
            
        case 2:
            questions.append(Question(text: "Rozwiń skrót RKO.", answers: [
            Answer(text: "Resuscytacja \nkrążeniowo-oddechowa", correct: true),
            Answer(text: "Resuscytacja krążeniowo-ogólna", correct: false),
            Answer(text: "Resutacja krążeniowo-oddechowa", correct: false),
            Answer(text: "Reanimacja kolano-odwrotowa", correct: false)
        ]))
        
        questions.append(Question(text: "Ile wynosi stosunek uciśnień do wdechów?", answers: [
            Answer(text: "25:2", correct: false),
            Answer(text: "30:2", correct: true),
            Answer(text: "40:2", correct: false),
            Answer(text: "30:3", correct: false)
        ]))
        
        questions.append(Question(text: "Co to jest AED?", answers: [
            Answer(text: "Automatyczny defibrulator \nzewnętrzny", correct: false),
            Answer(text: "Automatyczny defibrylator zewnętrznokomórkowy", correct: false),
            Answer(text: "Automatyczny defibrylator \nzewnętrzny", correct: true),
            Answer(text: "Automatyczny defibrylator \nwewnętrzny", correct: false)
        ]))
        
        questions.append(Question(text: "Co oznacza skrót NZK?", answers: [
            Answer(text: "Nagłe zatrzymanie krążenia", correct: true),
            Answer(text: "Natychmiasowe zatrzymanie \nkrążenia", correct: false),
            Answer(text: "Nagłe zwolnienie krążenia", correct: false),
            Answer(text: "Natychmiastowe zatrzymanie kości", correct: false)
        ]))
        
        questions.append(Question(text: "Gdzie należy umieścić ręce do robienia ucisków?", answers: [
            Answer(text: "2 cm nad pępkiem.", correct: false),
            Answer(text: "Środek mostka.", correct: true),
            Answer(text: "Tchawica.", correct: false),
            Answer(text: "Na lewej stronie klatki piersiowej.", correct: false)
        ]))
        
        questions.append(Question(text: "Co należy zrobić przed wprowadzeniem oddechów ratowniczych?", answers: [
            Answer(text: "Zablokować drogi oddechowe.", correct: false),
            Answer(text: "Udrożnić drogi oddechowe poszkodowanego.", correct: true),
            Answer(text: "Nie zatkać nosa.", correct: false),
            Answer(text: "Żadne z powyższych.", correct: false)
        ]))
        
        questions.append(Question(text: "Jaka jest prawidłowa częstotliwość ucisków?", answers: [
            Answer(text: "100-120 ucisków na minutę.", correct: true),
            Answer(text: "160-190 ucisków na minutę.", correct: false),
            Answer(text: "130-150 ucisków na minutę.", correct: false),
            Answer(text: "80-120 ucisków na minutę.", correct: false)
        ]))
            
        case 3:
            questions.append(Question(text: "Jaką czynność wykonasz na miejscu wypadku pomiędzy oceną bezpieczeństwa a wezwaniem pomocy?", answers: [
            Answer(text: "Przeprowadzę resuscytację.", correct: false),
            Answer(text: "Sprawdzę przytomność, odchylę \ngłowę, sprawdzę oddech.", correct: true),
            Answer(text: "Odchylę głowę i sprawdzę \nprzytomność.", correct: false),
            Answer(text: "Sprawdzę przytomność i wykonam \ndwa wdechy ratunkowe.", correct: false)
        ]))
        
        questions.append(Question(text: "Jak długo należy sprawdzać oddech u osoby nieprzytomnej?", answers: [
            Answer(text: "Przez 5 sekund.", correct: false),
            Answer(text: "Przez 10 sekund.", correct: true),
            Answer(text: "Przez 15 sekund.", correct: false),
            Answer(text: "Przez 20 sekund.", correct: false)
        ]))
        
        questions.append(Question(text: "Kogo układa się w pozycji bezpiecznej (bocznej)?", answers: [
            Answer(text: "Nieprzytomnego i \nnieoddychającego.", correct: false),
            Answer(text: "Oddychającego z podejrzeniem zawału serca.", correct: false),
            Answer(text: "Nieprzytomnego i oddychającego.", correct: true),
            Answer(text: "Poszkodowanego we wstrząsie pourazowym.", correct: false)
        ]))
        
        questions.append(Question(text: "Jaki jest numer alarmowy do Centrum Powiadamiania Ratunkowego?", answers: [
            Answer(text: "999", correct: false),
            Answer(text: "112", correct: true),
            Answer(text: "111", correct: false),
            Answer(text: "996", correct: false)
        ]))
        
        questions.append(Question(text: "Uszkodzone, w wyniku wypadku, pojazdy stanowią zagrożenie:", answers: [
            Answer(text: "dla wszystkich uczestników \nzdarzenia.", correct: false),
            Answer(text: "dla uczestników, ratowników i świadków zdarzenia.", correct: true),
            Answer(text: "dla osób znajdujących się wewnątrz pojazdów.", correct: false),
            Answer(text: "dla uczestników zdarzenia i \nratowników.", correct: false)
        ]))
        
        questions.append(Question(text: "Udzielając pomocy na miejscu wypadku kieruj się zasadą, że:", answers: [
            Answer(text: "najważniejsze jest bezpieczeństwo poszkodowanych.", correct: false),
            Answer(text: "najważniejsze jest szybkie \ndziałanie.", correct: false),
            Answer(text: "najważniejsze jest wydobycie poszkodowanych z uszkodzonych pojazdów.", correct: false),
            Answer(text: "najważniejsze jest bezpieczeństwo ratownika.", correct: true)
        ]))
            
        case 4:
            questions.append(Question(text: "Omdlenie jest efektem:", answers: [
            Answer(text: "patologicznych wyładowań w tkance mózgowej.", correct: false),
            Answer(text: "wzrostu ciśnienia w ośrodkowym układzie nerwowym.", correct: false),
            Answer(text: "upośledzenia perfuzji przez naczynia mózgowe.", correct: true),
            Answer(text: "żadne z wymienionych.", correct: false)
        ]))
        
        questions.append(Question(text: "Cechą omdlenia jest:", answers: [
            Answer(text: "nagłe wystąpienia.", correct: false),
            Answer(text: "całkowita utrata przytomności.", correct: false),
            Answer(text: "szybkie i całkowite ustąpienie \nobjawów.", correct: false),
            Answer(text: "wszystkie wymienione.", correct: true)
        ]))
        
        questions.append(Question(text: "Do omdlenia wazowagalnego może dojść w wyniku:", answers: [
            Answer(text: "instrumentacji na dużych \nnaczyniach i na widok krwi.", correct: true),
            Answer(text: "podczas wysiłku.", correct: false),
            Answer(text: "na widok krwi.", correct: false),
            Answer(text: "instrumentacji na dużych \nnaczyniach.", correct: false)
        ]))
        
        questions.append(Question(text: "W omdleniu odruchowym stwierdza się:", answers: [
            Answer(text: "zwolnienie akcji serca i poszerzenie łożyska naczyniowego.", correct: true),
            Answer(text: "tylko zwolnienie akcji serca.", correct: false),
            Answer(text: "zwolnienie akcji serca i skurcz \nnaczyń.", correct: false),
            Answer(text: "przyśpieszenie akcji serca i skurcz naczyń.", correct: false)
        ]))
        
        questions.append(Question(text: "Objawem poprzedzającym omdlenie z powodu niedociśnienia ortostatycznego może być:", answers: [
            Answer(text: "parcie na mocz.", correct: false),
            Answer(text: "szum w uszach.", correct: true),
            Answer(text: "wzrost temperatury ciała.", correct: false),
            Answer(text: "ból brzucha.", correct: false)
        ]))
        
        questions.append(Question(text: "Najpoważniejsze rokowanie mają omdlenia:", answers: [
            Answer(text: "wazowagalne.", correct: false),
            Answer(text: "kardiogenne.", correct: true),
            Answer(text: "z niedociśnienia ortostatycznego.", correct: false),
            Answer(text: "odruchowe.", correct: false)
        ]))
            
        case 5:
            questions.append(Question(text: "Miejsce przerwania powłok i tkanek miękkich organizmu to:", answers: [
            Answer(text: "krwotok.", correct: false),
            Answer(text: "rana.", correct: true),
            Answer(text: "złamanie.", correct: false),
            Answer(text: "zwichnięcie.", correct: false)
        ]))
        
        questions.append(Question(text: "Krwotok to:", answers: [
            Answer(text: "uszkodzenie zewnętrznych tkanek organizmu.", correct: false),
            Answer(text: "uszkodzenie drobnych naczyń krwionośnych.", correct: false),
            Answer(text: "zaczerwienienie i obrzęk w \nmiejscu urazu.", correct: false),
            Answer(text: "duża utrata krwi w wyniku doznanych urazów.", correct: true)
        ]))
        
        questions.append(Question(text: "Ze względu na rodzaj uszkodzonego naczynia krwawienia dzieli się na:", answers: [
            Answer(text: "zewnętrzne i tętnicze.", correct: false),
            Answer(text: "wewnętrzne i tętnicze.", correct: false),
            Answer(text: "wewnętrzne i żylne.", correct: false),
            Answer(text: "żylne i tętnicze.", correct: true)
        ]))
        
        questions.append(Question(text: "Ze względu na miejsce krwawienia dzieli się na:", answers: [
            Answer(text: "zewnętrzne i powierzchowne.", correct: false),
            Answer(text: "poważne i zagrażające zdrowiu.", correct: false),
            Answer(text: "zewnętrzne i wewnętrzne.", correct: true),
            Answer(text: "wewnętrzne i chorobotwórcze.", correct: false)
        ]))
        
        questions.append(Question(text: "Krwotok wewnętrzny charakteryzuje:", answers: [
            Answer(text: "rana powstała w wyniku ukłucia \nostrym narzędziem.", correct: false),
            Answer(text: "obtarcie naskórka.", correct: false),
            Answer(text: "brak widocznego krwawienia \nna skórze.", correct: true),
            Answer(text: "rana będąca wynikiem ukąszenia \nprzez dzikie zwierzę.", correct: false)
        ]))
        
        questions.append(Question(text: "Objawem wstrząsu krwotocznego nie są:", answers: [
            Answer(text: "nagła aktywność fizyczna \npołączona ze wzrostem \ntemperatury.", correct: true),
            Answer(text: "mroczki przed oczami, niepokój i dreszcze.", correct: false),
            Answer(text: "szum w uszach, \nbladość i zawroty głowy.", correct: false),
            Answer(text: "przyspieszone bicie serca, zimny \npot i omdlenia.", correct: false)
        ]))
            
        default:
            return
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  CommandsInformationViewController.swift
//  Comiditas
//
//  Created by Alley Pereira on 29/11/21.
//

import UIKit

class CommandsInformationViewController: UIViewController {

    var coordinator: CommandsInformationCoordinator?

    // MARK: - Model
    let commands: [CommandDescription] = [
        CommandDescription(
            title: "\"Receita, próximo passo\"",
            description: "Passar para a próxima instrução"
        ),
        CommandDescription(
            title: "\"Receita, iniciar temporizador\"",
            description: "Para iniciar o timer"
        ),
        CommandDescription(
            title: "\"Receita, pausar temporizador\"",
            description: "Para pausar o timer"
        ),
        CommandDescription(
            title: "\"Receita, reiniciar temporizador\"",
            description: "Para reiniciar o timer"
        ),
        CommandDescription(
            title: "\"Receita, ler passo atual\"",
            description: "Para que a receita do passo atual seja lida"
        )
    ]

    // MARK: - View
    lazy var informationView: CommandsInformationView = {
        let view = CommandsInformationView(frame: UIScreen.main.bounds)
        view.delegate = self
        view.informationTableView.delegate = self
        view.informationTableView.dataSource = self
        return view
    }()

    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func loadView() {
        super.loadView()
        self.view = informationView
    }

}

// MARK: UITableViewDelegate, UITableViewDataSource
extension CommandsInformationViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commands.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CommandsInformationTableViewCell.identifier,
            for: indexPath) as? CommandsInformationTableViewCell else {
            return UITableViewCell()
        }

        let command = commands[indexPath.row]
        cell.titleLabel.text = command.title
        cell.descriptionLabel.text = command.description
        return cell
    }

}

extension CommandsInformationViewController: InformationButtonDelegate {
    func dismissButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

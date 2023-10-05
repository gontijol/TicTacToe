import SwiftUI

struct ContentView: View {
    @State private var board = Array(repeating: "", count: 9)
    @State private var currentPlayer = "X"
    @State private var winner = ""

    var body: some View {
        VStack {
            Text("Jogo da Velha")
                .font(.largeTitle)
                .foregroundColor(Color.blue)
            
        
            Text("Jogador Atual: \(currentPlayer)")
                .font(.headline)
                .foregroundColor(Color.blue)
                .padding()

            LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                ForEach(0..<9, id: \.self) { index in
                    Button(action: {
                        if board[index] == "" && winner == "" {
                            board[index] = currentPlayer
                            checkWinner()
                            togglePlayer()
                        }
                    }) {
                        Text(board[index])
                            .font(.system(size: 60, weight: .bold))
                            .frame(width: 100, height: 100)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                                    .opacity(0.3)
                            )
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                            .padding(5)
                            .background(Color.blue.opacity(0.3))
                            .cornerRadius(10)
                    }
                }
            }
            .padding()

            Spacer()

            if winner != "" {
                Text("Vencedor: \(winner)")
                    .font(.title)
                    .foregroundColor(winner == "Empate" ? Color.gray : Color.green)
                    .padding()
            }
        }
        .background(Color.white)
    }

    private func togglePlayer() {
        currentPlayer = currentPlayer == "X" ? "O" : "X"
    }

    private func checkWinner() {
        let winningCombinations = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // Linhas
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // Colunas
            [0, 4, 8], [2, 4, 6] // Diagonais
        ]

        for combo in winningCombinations {
            if board[combo[0]] == currentPlayer && board[combo[1]] == currentPlayer && board[combo[2]] == currentPlayer {
                winner = currentPlayer
                return
            }
        }

        if !board.contains("") {
            winner = "Empate"
        }
    }
}

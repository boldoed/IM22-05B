import pygame
import random
import math
import pprint

# Определение цветов
BLACK = (0, 0, 0)
WHITE = (255, 255, 255)
RED = (255, 0, 0)

# Инициализация Pygame
pygame.init()

# Создание окна
WINDOW_SIZE = (700, 600)
screen = pygame.display.set_mode(WINDOW_SIZE)
pygame.display.set_caption("Four-in-a-Row")

def print_tree(node, indent=''):
    pprint.pprint(node.state.__dict__, indent=indent)
    for child in node.children:
        print_tree(child, indent + '  ')

# Представляет узел дерева поиска
class Node:
    def __init__(self, state, parent=None):
        self.state = state
        self.parent = parent
        self.children = []
        self.wins = 0
        self.visits = 0

    def select_child(self, exploration_constant): # Выбираем наилучшего потомка с помощью UCB.
        best_score = float('-inf')
        best_child = None

        for child in self.children:
            if child.visits == 0:
                score = float('inf')
            else:
                if self.visits == 0:
                    score = float('inf')
                else:
                    score = child.wins / child.visits + exploration_constant * math.sqrt(
                        math.log(self.visits) / (child.visits + 1)
                    )

            if score > best_score:
                best_score = score
                best_child = child

        return best_child

    def expand(self): #  Расширяем текущий узел, создавая новые дочерние узлы.
        available_moves = self.state.get_available_moves()

        if not available_moves:
            return None

        random_move = random.choice(available_moves)
        new_state = self.state.copy()
        new_state.make_move(random_move, new_state.current_player)
        child_node = Node(new_state, parent=self)
        self.children.append(child_node)
        return child_node

    def simulate_random_game(self): # Симулируем случайную игру
        state = self.state.copy()

        while not state.is_game_over():
            available_moves = state.get_available_moves()
            random_move = random.choice(available_moves)
            state.make_move(random_move, state.current_player)
            state.switch_players()

        if state.is_winner('O'):
            return 1
        elif state.is_winner('X'):
            return -1
        else:
            return 0

    def update(self, result): # Обновляем информацию по узлам
        self.visits += 1
        self.wins += result

# Класс игры и MCTS
class TicTacToe:
    def __init__(self):
        self.board = [' '] * 42
        self.current_player = 'X'
        self.root = None
        self.game_over = False
        self.winning_combinations = []
        self.create_winning_combinations()

    def create_winning_combinations(self): # Список выигрышных комбинаций
        # Rows
        for i in range(0, 42, 7):
            for j in range(i, i + 4):
                self.winning_combinations.append([j, j + 1, j + 2, j + 3])

        # Columns
        for i in range(7):
            for j in range(i, i + 21, 7):
                self.winning_combinations.append([j, j + 7, j + 14, j + 21])

        # Diagonals
        for i in range(3):
            for j in range(i, i + 15, 7):
                self.winning_combinations.append([j, j + 8, j + 16, j + 24])

        # Diagonals
        for i in range(3):
            for j in range(i + 3, i + 18, 7):
                self.winning_combinations.append([j, j + 6, j + 12, j + 18])

    def draw_board(self): # Отрисовка игры
        screen.fill(WHITE)
        for x in range(100, 700, 100):
            pygame.draw.line(screen, BLACK, (x, 0), (x, 600), 3)
        for y in range(100, 600, 100):
            pygame.draw.line(screen, BLACK, (0, y), (700, y), 3)

        for i in range(len(self.board)):
            col = i % 7
            row = i // 7
            x = col * 100 + 50
            y = row * 100 + 50

            if self.board[i] == 'X':
                pygame.draw.line(screen, BLACK, (x - 40, y - 40), (x + 40, y + 40), 5)
                pygame.draw.line(screen, BLACK, (x - 40, y + 40), (x + 40, y - 40), 5)
            elif self.board[i] == 'O':
                pygame.draw.circle(screen, BLACK, (x, y), 40, 5)

    def is_winner(self, player): # Проверка на победителя
        for combination in self.winning_combinations:
            if all(self.board[i] == player for i in combination):
                return True
        return False

    def is_draw(self): # Проверка ничьей
        return ' ' not in self.board

    def make_move(self, move, player): # Ход player на позицию move
        self.board[move] = player

    def switch_players(self): # Переключение ходящего
        self.current_player = 'O' if self.current_player == 'X' else 'X'

    def handle_click(self, pos): # Обработка кликов мышкой
        if not self.game_over and self.current_player == 'X':
            col = pos[0] // 100
            row = pos[1] // 100
            move = row * 7 + col

            if self.board[move] == ' ':
                self.make_move(move, self.current_player)
                self.switch_players()

                self.draw_board()
                pygame.display.update()

                if not self.is_game_over():
                    self.make_bot_move()

    def is_game_over(self): # Проверка завершения игры
        return self.is_winner('X') or self.is_winner('O') or self.is_draw()

    def make_bot_move(self): # Ход бота основанного на алгоритме MCTS
        root = Node(self)
        self.root = root
        iterations = 10000

        for _ in range(iterations):
            selected_node = self.selection(root)
            expanded_node = selected_node.expand()

            if expanded_node is not None:
                result = expanded_node.simulate_random_game()
                expanded_node.update(result)

        best_child = root.select_child(0)
        best_move = self.get_move_from_state(best_child)

        self.make_move(best_move, self.current_player)
        self.switch_players()

        self.draw_board()
        pygame.display.update()

    def selection(self, node): # Выбор лучшего дочернего узла
        while len(node.children) > 0:
            node = node.select_child(math.sqrt(2))

        return node

    def get_move_from_state(self, child_node): # Ход из указанного дочернего узла
        for move in self.get_available_moves():
            temp_state = self.copy()
            temp_state.make_move(move, temp_state.current_player)
            if temp_state.is_equal(child_node.state):
                return move

    def copy(self): # Копирует состояние игры 
        copied_state = TicTacToe()
        copied_state.board = list(self.board)
        copied_state.current_player = self.current_player
        copied_state.game_over = self.game_over
        return copied_state

    def is_equal(self, state): # Проверяю является ли текущее состояние равым заданному
        return self.board == state.board and self.current_player == state.current_player

    def get_available_moves(self): # Список доступных ходов
        return [i for i, val in enumerate(self.board) if val == ' ']

    def play(self): # Основной код игры
        clock = pygame.time.Clock()
        restart = False

        while True:
            if restart:
                self.__init__()
                restart = False

            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    pygame.quit()
                    return

                if event.type == pygame.MOUSEBUTTONUP and not self.game_over:
                    pos = pygame.mouse.get_pos()
                    self.handle_click(pos)

                if event.type == pygame.KEYDOWN and self.game_over:
                    if event.key == pygame.K_r:
                        restart = True

            self.draw_board()
            pygame.display.update()

            if self.is_winner('X'):
                self.game_over = True
                font = pygame.font.Font(None, 36)
                text = font.render(" Игрок X выиграл! ", True, RED, BLACK)
                screen.blit(text, (230, 300))
            elif self.is_winner('O'):
                self.game_over = True
                font = pygame.font.Font(None, 36)
                text = font.render(" Игрок O выиграл! ", True, RED, BLACK)
                screen.blit(text, (230, 300))
            elif self.is_draw():
                self.game_over = True
                font = pygame.font.Font(None, 36)
                text = font.render(" Ничья! ", True, RED, BLACK)
                screen.blit(text, (300, 300))

            # if self.is_winner('X') or self.is_winner('O') or self.is_draw():
            #     print("Дерево MCTS:")
            #     pprint.pprint(self.root.__dict__)

            pygame.display.flip()
            clock.tick(60)


if __name__ == '__main__':
    game = TicTacToe()
    game.play()

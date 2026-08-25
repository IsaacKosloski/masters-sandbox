# Roteiro do vídeo (≈ 5 minutos) — MLP para o XOR em PyTorch

Objetivo do vídeo: explicar o código e mostrar o modelo treinando. Fale com calma, mostrando a tela do notebook e rodando as células na ordem. Abaixo, uma sugestão de fala e de tempo por trecho.

---

## 0:00 – 0:30 · Abertura e problema
- Apresente-se e diga o objetivo: "implementar em PyTorch uma rede neural MLP que aprende a função lógica XOR".
- Mostre a tabela verdade do XOR (célula de título) e explique em uma frase por que ele é interessante: **não é linearmente separável**, então um perceptron simples não resolve — precisamos de uma **camada oculta** com ativação não linear.

## 0:30 – 1:00 · Bibliotecas e hiperparâmetros
- Rode a célula de imports. Cite rapidamente o papel de cada uma: `torch` (tensores/autograd), `torch.nn` (camadas e perdas), `torch.optim` (otimizadores), `DataLoader` (batches), `matplotlib` (gráfico).
- Mostre o bloco de **hiperparâmetros** e leia os valores obrigatórios: `LEARNING_RATE=0.001`, `EPOCHS=10000`, `BATCH_SIZE=1` (SGD estocástico), `OPTIMIZER=SGD` (momentum 0.8, weight_decay 1e‑4), ativação oculta **ReLU** e saída **Sigmoid**, perda **MSE**. Destaque que centralizar tudo aqui facilita testar outras configurações.

## 1:00 – 1:40 · Dados, Dataset e DataLoader
- Rode a célula da **base XOR**: mostre `X` (4×2) e `y` (4×1) construídos com `torch.tensor`. Aponte que cada linha de `X` corresponde a uma linha de `y`.
- Rode a célula do `TensorDataset` + `DataLoader`. Explique: o Dataset emparelha entrada/saída; o DataLoader entrega os dados em batches de tamanho 1 e embaralha (`shuffle=True`) a cada época.

## 1:40 – 2:30 · Arquitetura da rede
- Rode o bloco de escolha da ativação (mostra que `ACTIVATION="relu"` vira `nn.ReLU()`).
- Rode a **construção da MLP**: explique o bloco fundamental "Linear → ativação". Camada de entrada `Linear(2, 3)`, ReLU, e camada de saída `Linear(3, 1)` seguida de `Sigmoid`, que comprime a saída para (0,1) — interpretável como probabilidade da classe 1.
- Mostre o `print(model)` com o `Sequential` das 4 camadas.

## 2:30 – 3:00 · Perda e otimizador
- Rode a célula do `criterion = nn.MSELoss()` e do otimizador `SGD`. Explique em uma frase cada argumento: `lr` (tamanho do passo), `momentum` (acelera a convergência) e `weight_decay` (regularização L2).

## 3:00 – 4:00 · Loop de treinamento (o coração do código)
- Rode a célula de treino. Enquanto os prints de época aparecem, explique os **5 passos por batch**:
  1. `optimizer.zero_grad()` — zera gradientes acumulados;
  2. `model(batch_x)` — forward pass;
  3. `criterion(pred, batch_y)` — calcula a Loss (MSE);
  4. `loss.backward()` — backpropagation via Autograd;
  5. `optimizer.step()` — atualiza pesos e bias.
- Cite o **Early Stopping**: se a Loss não melhora por `PATIENCE=100` épocas, o treino para.
- Comente o que se vê nos prints: a Loss começa perto de **0.25** (platô inicial) e depois **cai** conforme a rede aprende a separar as classes.

## 4:00 – 4:40 · Avaliação e resultados
- Rode a célula de teste (`model.eval()` + `torch.no_grad()`). Leia a tabela de resultados: para `[0,0]` e `[1,1]` a saída fica perto de 0; para `[0,1]` e `[1,0]`, perto de 1. Mostre a **acurácia 4/4**.
- Explique o limiar de decisão 0.5 (≥ 0.5 → classe 1, senão classe 0).

## 4:40 – 5:00 · Gráfico e fechamento
- Rode a célula do gráfico e mostre a **Curva de Aprendizado**: platô inicial em ~0.25 e depois a descida até perto de 0 — sinal de que a rede aprendeu o XOR.
- Feche resumindo: MLP com 1 camada oculta + ativação não linear resolve o XOR; os hiperparâmetros da aula foram usados; o código é totalmente parametrizado para experimentação.

---

### Dicas de gravação
- Rode todas as células **antes** de gravar (Kernel → Restart & Run All) para garantir que tudo funciona; depois grave executando de novo na ordem.
- Se preferir uma convergência mais rápida para mostrar no vídeo, troque no topo: `OPTIMIZER="Adam"`, `LEARNING_RATE=0.05`, `ACTIVATION="tanh"`, `NEURONS=8`. Nenhuma outra linha muda.
- Deixe o zoom da fonte do notebook maior para a leitura na gravação.

# MLP para o XOR em PyTorch

Conteúdo do arquivo entregue:

- `XOR_MLP_PyTorch.ipynb` — notebook comentado com a implementação completa (dataset, arquitetura, perda/otimizador, treino com Early Stopping, avaliação das 4 combinações e gráfico da Loss).
- `curva_aprendizado.png` — gráfico da evolução da Loss durante o treinamento.
- `roteiro_video.md` — roteiro do vídeo de 5 minutos explicando o código.

## Como executar
Requisitos: Python 3 com `torch` e `matplotlib`.

```bash
pip install torch matplotlib
jupyter notebook XOR_MLP_PyTorch.ipynb
```

Depois use **Kernel → Restart & Run All**.

## Hiperparâmetros usados (conforme a Aula 3)
- Learning rate: 0.001
- Épocas: 10000 (com Early Stopping, paciência 100)
- Batch size: 1 (Gradiente Descendente Estocástico)
- Otimizador: SGD (momentum 0.8, weight_decay 1e‑4)
- Função de perda: MSELoss
- Ativação da camada oculta: ReLU
- Ativação da saída: Sigmoid

## Resultado
A rede aprende o XOR, classificando corretamente as quatro combinações (acurácia 4/4). A
curva de Loss mostra um platô inicial próximo de 0.25 seguido de queda até perto de zero.

> Observação: o gráfico `curva_aprendizado.png` foi gerado a partir desta mesma arquitetura
> e hiperparâmetros. Ao rodar o notebook em PyTorch, o próprio notebook regenera o gráfico.

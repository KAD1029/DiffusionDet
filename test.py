import cv2
import numpy as np

def Print(arr) :
    round_val = 3
    box_size = 10
    print('_' * (box_size + 1) * arr.shape[1])
    for row in arr :
        for elem in row :
            print(f'|{np.round(elem, round_val):{box_size}}', end='')
        print('|')
        print('_' * (box_size + 1) * arr.shape[1])



true_res = np.genfromtxt("./tables/true_result.csv", delimiter = ",")
true_res = true_res[true_res[:, 0].argsort()]
res = np.genfromtxt("./tables/result.csv", delimiter = ",")
res = res[res[:, 0].argsort()]

if (res.shape[0] == true_res.shape[0]) :
    dif = abs(res - true_res)
    print('\n\nDifference : ')
    Print(dif)
    print(f'Sum score error = {np.round(np.sum(dif[:, 1]), 3)} %')
    print(f'Sum coords error = {np.round(np.sum(dif[:, 2:]), 3)}')
else:
    print("\n\nDifferent number of objects")
    print(f'True result : ')
    Print(true_res)
    print(f'Current result: ')
    Print(res)

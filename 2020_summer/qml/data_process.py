import numpy as np
import json
import math

from matplotlib import pyplot
pyplot.style.use('ggplot')

# Plotting configuration
cases = [(0, 0), (0, 1), (1, 1), (1, 0)]
markers = [
    '.' if actual == classified else 'X'
    for (actual, classified) in cases
]
colors = ['blue', 'blue', 'red', 'red']



def plot_data (features : list, actual_labels : list, classified_labels : list = None, extra_lines : list = None):
    """Plots the data, labeling it with actual labels if there are no classification results provided, 
    and with the classification results (indicating their correctness) if they are provided.
    """
    samples = np.array(features)
    pyplot.figure(figsize=(8, 8))
    for (idx_case, ((actual, classified), marker, color)) in enumerate(zip(cases, markers, colors)):
        mask = np.logical_and(np.equal(actual_labels, actual), 
                              np.equal(actual if classified_labels == None else classified_labels, classified))
        if not np.any(mask): continue
        pyplot.scatter(
            samples[mask, 0], samples[mask, 1],
            label = f"Class {actual}" if classified_labels == None else f"Was {actual}, classified {classified}",
            marker = marker, s = 300, c = [color],
        )
    # Add the lines to show the true classes boundaries, if provided
    if extra_lines != None:
        for line in extra_lines:
            pyplot.plot(line[0], line[1], color = 'gray')
    pyplot.legend()
    pyplot.show()

def preprocess_data(features, labels):
    to_return = []
    for datum, label in zip(features, labels):
        norm = math.sqrt(datum[0] ** 2 + datum [1] ** 2)
        to_return.append([datum[0]/norm, datum[1]/norm, labels])
    return to_return

with open('../contest/d1_data.json') as json_file:
    data = json.load(json_file)
    #print(data['Labels'])
    #plot_data(preprocess_data(data['Features'], data['Labels']), data['Labels'])

    features = preprocess_data(data['Features'], data['Labels'])
    samples = np.array(features)
    X = samples[:0]
    Y = samples[:1]
    Z = samples[:2]
    
    fig = pyplot.figure(figsize=(8, 8))
    ax = fig.add_subplot(projection='3d')
    surf = ax.scatter(X, Y, Z)
    pyplot.legend()
    pyplot.show()
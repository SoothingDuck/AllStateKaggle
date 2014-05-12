import sys
sys.path.append("lib")

from AllStateDataLoader import AllStateDataLoader
from AllStatePredictor import AllStatePredictor
from sklearn import linear_model
from sklearn import grid_search
import numpy as np

p = AllStatePredictor()

y_2_predict = p.predict_simple("2", "linearsvc", "ABCDEFG", kind="test")
y_3_predict = p.predict_simple("3", "linearsvc", "ABCDEFG", kind="test")
y_4_predict = p.predict_simple("4", "linearsvc", "ABCDEFG", kind="test")
y_all_predict = p.predict_simple("all", "linearsvc", "ABCDEFG", kind="test")


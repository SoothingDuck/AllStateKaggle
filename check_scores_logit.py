import os
from sklearn.externals import joblib

for type_data in ["2","3","all"]:
    for letter in "ABCDEFG":
        model_filename = os.path.join("model_logistic", "model_logistic_data_%s_%s_not_centered.pkl" % (type_data, letter))
        model = joblib.load(model_filename)
        print "%s : %s => %0.4f" % (type_data, letter, model.best_score_)


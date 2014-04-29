

import os
import numpy as np
from sklearn.externals import joblib
from AllStateDataLoader import AllStateDataLoader


class AllStatePredictor():
    """Object de prediction"""
    def __init__(self):
        self.__datasets = {}
        self.__dataloader = AllStateDataLoader()
        self.debug = True


    def __get_dataset(self, type_dataset):
        """Recuperation du dataset (lazy)"""

        if type_dataset == "2":
            if not self.__datasets.has_key("2"):
                self.__datasets["2"] = self.__dataloader.get_data_2_test()
            return self.__datasets["2"]
        elif type_dataset == "3":
            if not self.__datasets.has_key("3"):
                self.__datasets["3"] = self.__dataloader.get_data_3_test()
            return self.__datasets["3"]
        if type_dataset == "all":
            if not self.__datasets.has_key("all"):
                self.__datasets["all"] = self.__dataloader.get_data_all_test()
            return self.__datasets["all"]

    def get_X_columns(self, type_dataset):
        """Recuperation de la liste des colonnes d'un dataset particulier"""
        dataset = self.__get_dataset(type_dataset)

        return [x for x in dataset.columns if x not in ["real_%s" % letter for letter in ['A','B','C','D','E','F','G']]]


    def get_X(self, type_dataset):
        """Recuperation de X"""
        dataset = self.__get_dataset(type_dataset)
        tmp = dataset.copy()

        for variable in ["real_%s" % x for x in ['A','B','C','D','E','F','G'] if "real_%s" % x in self.get_X_columns(type_dataset)]:
            del tmp[variable]

        return np.array(tmp)

    def get_customer_ID_list(self, type_dataset):
        """Recuperation de la liste des customer_ID"""
        dataset = self.__get_dataset(type_dataset)
        tmp = dataset.copy()
  
        return np.array(tmp.index)

    def __get_model(self, letter, type_prediction, centered_or_not, type_dataset):
        filename = os.path.join("model_%s" % type_prediction, "model_%s_data_%s_%s_%s.pkl" % (type_prediction, type_dataset, letter, centered_or_not))

        model = joblib.load(filename)

        return model

    def predict(self, letter, type_prediction, centered_or_not, type_dataset):
        """Fonction prediction"""

        X = self.get_X(type_dataset)

        model = self.__get_model(letter, type_prediction, centered_or_not, type_dataset)

        return model.predict(X)

import sys

sys.path.append("lib")
from AllStateDataLoader import AllStateDataLoader


class AllStatePredictor():
    """Object de prediction"""
    def __init__(self):
        self.__datasets = {}
        self.__dataloader = AllStateDataLoader()
        self.debug = True


    def __get_dataset(self, type_dataset):
        """Recuperation du dataset (lazy)"""
        if self.debug:
            print "Recuperation dataset %s" % type_dataset

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

                

    def predict(self, letter, type_prediction, centered_or_not, type_dataset):
        """Fonction prediction"""
        dataset = self.__get_dataset(type_dataset)
            

p = AllStatePredictor()


a_prediction_2 = p.predict("A", "linearsvc", "not_centered", "2")
b_prediction_2 = p.predict("A", "linearsvc", "not_centered", "2")
c_prediction_2 = p.predict("A", "linearsvc", "not_centered", "2")
d_prediction_2 = p.predict("A", "linearsvc", "not_centered", "2")
e_prediction_2 = p.predict("A", "linearsvc", "not_centered", "2")
f_prediction_2 = p.predict("A", "linearsvc", "not_centered", "2")
g_prediction_2 = p.predict("A", "linearsvc", "not_centered", "2")


import sys
sys.path.append("lib")

from AllStatePredictor import AllStatePredictor

p = AllStatePredictor()

print "prediction classe 2 linear svc..."
customer_ID_list_2 = p.get_customer_ID_list("2")
a_prediction_2 = p.predict("A", "linearsvc", "not_centered", "2")
b_prediction_2 = p.predict("B", "linearsvc", "not_centered", "2")
c_prediction_2 = p.predict("C", "linearsvc", "not_centered", "2")
d_prediction_2 = p.predict("D", "linearsvc", "not_centered", "2")
e_prediction_2 = p.predict("E", "linearsvc", "not_centered", "2")
f_prediction_2 = p.predict("F", "linearsvc", "not_centered", "2")
g_prediction_2 = p.predict("G", "linearsvc", "not_centered", "2")

print "prediction classe 3 linear svc..."
customer_ID_list_3 = p.get_customer_ID_list("3")
a_prediction_3 = p.predict("A", "linearsvc", "not_centered", "3")
b_prediction_3 = p.predict("B", "linearsvc", "not_centered", "3")
c_prediction_3 = p.predict("C", "linearsvc", "not_centered", "3")
d_prediction_3 = p.predict("D", "linearsvc", "not_centered", "3")
e_prediction_3 = p.predict("E", "linearsvc", "not_centered", "3")
f_prediction_3 = p.predict("F", "linearsvc", "not_centered", "3")
g_prediction_3 = p.predict("G", "linearsvc", "not_centered", "3")

print "prediction classe all linear svc..."
customer_ID_list_all = p.get_customer_ID_list("all")
a_prediction_all = p.predict("A", "linearsvc", "not_centered", "all")
b_prediction_all = p.predict("B", "linearsvc", "not_centered", "all")
c_prediction_all = p.predict("C", "linearsvc", "not_centered", "all")
d_prediction_all = p.predict("D", "linearsvc", "not_centered", "all")
e_prediction_all = p.predict("E", "linearsvc", "not_centered", "all")
f_prediction_all = p.predict("F", "linearsvc", "not_centered", "all")
g_prediction_all = p.predict("G", "linearsvc", "not_centered", "all")

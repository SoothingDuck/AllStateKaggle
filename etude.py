import sqlite3
import os
from pandas.io import sql
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

def get_data_2_set():

    # Connection
    cnx = sqlite3.connect(os.path.join('db', 'allstate_data.sqlite3'))

    # read_data
    data_2 = sql.read_sql("""
select
T1.customer_ID as customer_ID,
cust.state as state,
T3.day as day,
T3.time as time,
T3.group_size as group_size,
T3.homeowner as homeowner,
T3.car_age as car_age,
T3.car_value as car_value,
T3.risk_factor as risk_factor,
T3.age_youngest as age_youngest,
T3.age_oldest as age_oldest,
T3.married_couple as married_couple,
T3.C_previous as C_previous,
T3.duration_previous as duration_previous,
T3.cost as value_cost_pt_2,
T4.avg_cost as avg_cost,
T4.min_cost as min_cost,
T4.max_cost as max_cost,
T3.A as value_A_pt_2,
T3.B as value_B_pt_2,
T3.C as value_C_pt_2,
T3.D as value_D_pt_2,
T3.E as value_E_pt_2,
T3.F as value_F_pt_2,
T3.G as value_G_pt_2,
T5.A as first_A,
T5.B as first_B,
T5.C as first_C,
T5.D as first_D,
T5.E as first_E,
T5.F as first_F,
T5.G as first_G,
T2.A as real_A,
T2.B as real_B,
T2.C as real_C,
T2.D as real_D,
T2.E as real_E,
T2.F as real_F,
T2.G as real_G
from
transactions T1
inner join
customers cust on (T1.customer_ID = cust.customer_ID and cust.dataset = 'train')
inner join
(
select
*
from
transactions
where
record_type = 1
) T2 on (T1.customer_ID = T2.customer_ID)
inner join
(
select
*
from
transactions
where
shopping_pt = 2
) T3 on (T1.customer_ID = T3.customer_ID and T1.shopping_pt = T3.shopping_pt)
inner join
(
select
customer_ID,
avg(cost) as avg_cost,
min(cost) as min_cost,
max(cost) as max_cost
from
transactions
where shopping_pt <= 2
group by 1
) T4 on (T1.customer_ID = T4.customer_ID)
inner join
(
select
*
from
transactions
where
shopping_pt = 1
) T5 on (T1.customer_ID = T5.customer_ID)

""", cnx)

    data_2 = data_2.set_index(['customer_ID'])

    # not null columns
    for column in ['state', 'homeowner', 'car_value', 'married_couple']:
        tmp = pd.DataFrame(pd.get_dummies(data_2[column], prefix=column), index=data_2.index)
        data_2 = pd.merge(data_2, tmp, left_index=True, right_index=True)
        del data_2[column]

    for variable in ['value_%s_pt_2' % x for x in ['A','B','C','D','E','F','G']]:
        tmp = pd.DataFrame(pd.get_dummies(data_2[variable], prefix=variable), index=data_2.index)
        data_2 = pd.merge(data_2, tmp, left_index=True, right_index=True)
        del data_2[variable]

    for variable in ['first_%s' % x for x in ['A','B','C','D','E','F','G']]:
        tmp = pd.DataFrame(pd.get_dummies(data_2[variable], prefix=variable), index=data_2.index)
        data_2 = pd.merge(data_2, tmp, left_index=True, right_index=True)
        del data_2[variable]

    # na variable
    for variable in ['risk_factor', 'C_previous', 'duration_previous']:
        data_2[variable] = np.where(pd.isnull(data_2[variable]), "NotAvailable", data_2[variable])
        data_2[variable] = data_2[variable].str.replace(".0", "")
        tmp = pd.DataFrame(pd.get_dummies(data_2[variable], prefix=variable), index=data_2.index)
        data_2 = pd.merge(data_2, tmp, left_index=True, right_index=True)
        del data_2[variable]

    # drop variable
    for variable in ['day', 'time']:
        del data_2[variable]

    return data_2


def get_X_columns(data):

    return [x for x in data.columns if x not in ["real_%s" % letter for letter in ['A','B','C','D','E','F','G']]]


def get_X(data):
    tmp = data.copy()

    for variable in ["real_%s" % x for x in ['A','B','C','D','E','F','G']]:
        del tmp[variable]

    return np.array(tmp)

def get_y(letter, value, data):

    tmp = data.copy()

    return np.array(np.where(tmp["real_%s" % letter] == value, 1, 0))

    
from sklearn import linear_model
from sklearn.externals import joblib

from sklearn import grid_search

data_2 = get_data_2_set()

# G
X = get_X(data_2)
y = get_y("G", 1, data_2)

parameters = {'penalty' : ('l1', 'l2'), 'C' : [0.1, 0.5, 1, 5]}
log = linear_model.LogisticRegression()

log_data_2_G_1 = grid_search.GridSearchCV(log, parameters, verbose=2)
log_data_2_G_1.fit(X,y)

# G
X = get_X(data_2)
y = get_y("G", 2, data_2)

parameters = {'penalty' : ('l1', 'l2'), 'C' : [0.1, 0.5, 1, 5]}
log = linear_model.LogisticRegression()

log_data_2_G_2 = grid_search.GridSearchCV(log, parameters, verbose=2)
log_data_2_G_2.fit(X,y)

# G
X = get_X(data_2)
y = get_y("G", 3, data_2)

parameters = {'penalty' : ('l1', 'l2'), 'C' : [0.1, 0.5, 1, 5]}
log = linear_model.LogisticRegression()

log_data_2_G_3 = grid_search.GridSearchCV(log, parameters, verbose=2)
log_data_2_G_3.fit(X,y)

# G
X = get_X(data_2)
y = get_y("G", 4, data_2)

parameters = {'penalty' : ('l1', 'l2'), 'C' : [0.1, 0.5, 1, 5]}
log = linear_model.LogisticRegression()

log_data_2_G_4 = grid_search.GridSearchCV(log, parameters, verbose=2)
log_data_2_G_4.fit(X,y)

# sauvegarde
joblib.dump(log_data_2_G_1, 'model_logistic_data_2_G_1.pkl') 
joblib.dump(log_data_2_G_2, 'model_logistic_data_2_G_2.pkl') 
joblib.dump(log_data_2_G_3, 'model_logistic_data_2_G_3.pkl') 
joblib.dump(log_data_2_G_4, 'model_logistic_data_2_G_4.pkl') 

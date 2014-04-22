import sqlite3
import os
from pandas.io import sql
import pandas as pd
import numpy as np
# import matplotlib.pyplot as plt
from sklearn import preprocessing


def get_data_2_set():

    # Connection
    cnx = sqlite3.connect(os.path.join('db', 'allstate_data.sqlite3'))

    # read_data
    data = sql.read_sql("""
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

    data = data.set_index(['customer_ID'])

    # not null columns
    for column in ['state', 'homeowner', 'car_value', 'married_couple']:
        tmp = pd.DataFrame(pd.get_dummies(data[column], prefix=column), index=data.index)
        data = pd.merge(data, tmp, left_index=True, right_index=True)
        del data[column]

    for variable in ['value_%s_pt_2' % x for x in ['A','B','C','D','E','F','G']]:
        tmp = pd.DataFrame(pd.get_dummies(data[variable], prefix=variable), index=data.index)
        data = pd.merge(data, tmp, left_index=True, right_index=True)
        del data[variable]

    for variable in ['first_%s' % x for x in ['A','B','C','D','E','F','G']]:
        tmp = pd.DataFrame(pd.get_dummies(data[variable], prefix=variable), index=data.index)
        data = pd.merge(data, tmp, left_index=True, right_index=True)
        del data[variable]

    # na variable
    for variable in ['risk_factor', 'C_previous', 'duration_previous']:
        data[variable] = np.where(pd.isnull(data[variable]), "NotAvailable", data[variable])
        data[variable] = data[variable].str.replace(".0", "")
        tmp = pd.DataFrame(pd.get_dummies(data[variable], prefix=variable), index=data.index)
        data = pd.merge(data, tmp, left_index=True, right_index=True)
        del data[variable]

    # drop variable
    for variable in ['day', 'time']:
        del data[variable]

    cnx.close()
    
    data = data.reindex(columns=sorted(list(data.columns)))

    return data


def get_data_3_set():

    # Connection
    cnx = sqlite3.connect(os.path.join('db', 'allstate_data.sqlite3'))

    # read_data
    data = sql.read_sql("""
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
  T3.cost as value_cost_pt_3,
  T4.avg_cost as avg_cost,
  T4.min_cost as min_cost,
  T4.max_cost as max_cost,
  T3.A as value_A_pt_3,
  T3.B as value_B_pt_3,
  T3.C as value_C_pt_3,
  T3.D as value_D_pt_3,
  T3.E as value_E_pt_3,
  T3.F as value_F_pt_3,
  T3.G as value_G_pt_3,
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
  shopping_pt = 3
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
  where shopping_pt <= 3
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

    data = data.set_index(['customer_ID'])

    # not null columns
    for column in ['state', 'homeowner', 'car_value', 'married_couple']:
        tmp = pd.DataFrame(pd.get_dummies(data[column], prefix=column), index=data.index)
        data = pd.merge(data, tmp, left_index=True, right_index=True)
        del data[column]

    for variable in ['value_%s_pt_3' % x for x in ['A','B','C','D','E','F','G']]:
        tmp = pd.DataFrame(pd.get_dummies(data[variable], prefix=variable), index=data.index)
        data = pd.merge(data, tmp, left_index=True, right_index=True)
        del data[variable]

    for variable in ['first_%s' % x for x in ['A','B','C','D','E','F','G']]:
        tmp = pd.DataFrame(pd.get_dummies(data[variable], prefix=variable), index=data.index)
        data = pd.merge(data, tmp, left_index=True, right_index=True)
        del data[variable]

    # na variable
    for variable in ['risk_factor', 'C_previous', 'duration_previous']:
        data[variable] = np.where(pd.isnull(data[variable]), "NotAvailable", data[variable])
        data[variable] = data[variable].str.replace(".0", "")
        tmp = pd.DataFrame(pd.get_dummies(data[variable], prefix=variable), index=data.index)
        data = pd.merge(data, tmp, left_index=True, right_index=True)
        del data[variable]

    # drop variable
    for variable in ['day', 'time']:
        del data[variable]

    cnx.close()

    data = data.reindex(columns=sorted(list(data.columns)))

    return data


def get_data_all_set():

    # Connection
    cnx = sqlite3.connect(os.path.join('db', 'allstate_data.sqlite3'))

    # read_data
    data_max_shopping_pt = sql.read_sql("""
    select 
    customer_ID,
    max(shopping_pt) as last_shopping_pt
    from transactions
    where
    record_type = 0
    group by 1
""", cnx)

    data = sql.read_sql("""
  select
  T1.customer_ID as customer_ID,
  T1.shopping_pt as shopping_pt,
  cust.state as state,
  T1.day as day,
  T1.time as time,
  T1.group_size as group_size,
  T1.homeowner as homeowner,
  T1.car_age as car_age,
  T1.car_value as car_value,
  T1.risk_factor as risk_factor,
  T1.age_youngest as age_youngest,
  T1.age_oldest as age_oldest,
  T1.married_couple as married_couple,
  T1.C_previous as C_previous,
  T1.duration_previous as duration_previous,
  T1.cost as value_cost_last,
  T4.avg_cost as avg_cost,
  T4.min_cost as min_cost,
  T4.max_cost as max_cost,
  T1.A as value_A_last,
  T1.B as value_B_last,
  T1.C as value_C_last,
  T1.D as value_D_last,
  T1.E as value_E_last,
  T1.F as value_F_last,
  T1.G as value_G_last,
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
  customer_ID,
  avg(cost) as avg_cost,
  min(cost) as min_cost,
  max(cost) as max_cost
  from
  transactions
  where record_type = 0
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

    data = pd.merge(data, data_max_shopping_pt, left_on = ['customer_ID', 'shopping_pt'], right_on = ['customer_ID', 'last_shopping_pt'])

    del data['shopping_pt']
    del data['last_shopping_pt']

    data = data.set_index(['customer_ID'])

    # not null columns
    for column in ['state', 'homeowner', 'car_value', 'married_couple']:
        tmp = pd.DataFrame(pd.get_dummies(data[column], prefix=column), index=data.index)
        data = pd.merge(data, tmp, left_index=True, right_index=True)
        del data[column]

    for variable in ['value_%s_last' % x for x in ['A','B','C','D','E','F','G']]:
        tmp = pd.DataFrame(pd.get_dummies(data[variable], prefix=variable), index=data.index)
        data = pd.merge(data, tmp, left_index=True, right_index=True)
        del data[variable]

    for variable in ['first_%s' % x for x in ['A','B','C','D','E','F','G']]:
        tmp = pd.DataFrame(pd.get_dummies(data[variable], prefix=variable), index=data.index)
        data = pd.merge(data, tmp, left_index=True, right_index=True)
        del data[variable]

    # na variable
    for variable in ['risk_factor', 'C_previous', 'duration_previous']:
        data[variable] = np.where(pd.isnull(data[variable]), "NotAvailable", data[variable])
        data[variable] = data[variable].str.replace(".0", "")
        tmp = pd.DataFrame(pd.get_dummies(data[variable], prefix=variable), index=data.index)
        data = pd.merge(data, tmp, left_index=True, right_index=True)
        del data[variable]

    # drop variable
    for variable in ['day', 'time']:
        del data[variable]

    cnx.close()

    data = data.reindex(columns=sorted(list(data.columns)))

    return data


def get_X_columns(data):

    return [x for x in data.columns if x not in ["real_%s" % letter for letter in ['A','B','C','D','E','F','G']]]


def get_X_with_scaler(data):
    tmp = data.copy()

    for variable in ["real_%s" % x for x in ['A','B','C','D','E','F','G']]:
        del tmp[variable]

    scaler = preprocessing.StandardScaler()
    scaler.fit(tmp)

    return (scaler, scaler.transform(tmp))

def get_y_value(letter, value, data):

    tmp = data.copy()

    return np.array(np.where(tmp["real_%s" % letter] == value, 1, 0))

def get_y(letter, data):

    tmp = data.copy()

    return np.array(tmp["real_%s" % letter])


from sklearn import linear_model
from sklearn.externals import joblib
from sklearn import grid_search

data_2 = get_data_2_set()
data_3 = get_data_3_set()
data_all = get_data_all_set()

def fit_and_save_log(parameters, dataset, letter, scaler, filename,verbose=2):
    log = linear_model.LogisticRegression()

    scaler, X = get_X(dataset)
    y = get_y(letter, dataset)

    model = grid_search.GridSearchCV(log, parameters, verbose=verbose)
    model.fit(X,y)
    joblib.dump(model, filename)

    return model


# fitting models
parameters = {'penalty' : ['l1','l2'], 'C' : [0.1, 0.5, 1, 5]}

model_list = {}
dataset = {'2' : data_2, '3' : data_3, 'all' : data_all}

for letter in ['A','B','C','D','E','F','G']:
    model_list[letter] = {}
    for datasetname in dataset.keys():
        data = dataset[datasetname]
        model = fit_and_save_log(parameters, data, letter, "model_logistic_data_%s_%s_centered.pkl" % (datasetname, letter))
        
        model_list[letter][datasetname] = model

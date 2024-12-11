import pandas as pd #importing all the import libraries
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import sklearn

df = pd.read_csv('/content/Credit_card.csv') #loading the data
     

df1 = pd.read_csv('/content/Credit_card_label.csv')
df.insert(18 ,"Credit_card_approval", df1['label'], True)
df

df.nunique() #checking the unique values

df.isnull().sum() #checking for null values

data = df['Annual_income']
mean = np.mean(data) #using numpy mean
std = np.std(data) #using numpy std

outlier_upper = [i for i in data if i > mean+1.5*std]
outlier_lower = [i for i in data if i < mean-1.5*std]

data1 = sorted(data)
     

outliers = [i for i in outlier_upper if i in data1]
     

no_outliers = [i for i in data1 if i not in outliers]

     

df['new_Annual_income'] = pd.Series(no_outliers)

sns.histplot(df['new_Annual_income'])
plt.axvline(x=df['new_Annual_income'].mean(),
            color='red', linestyle= '--')
plt.axvline(x=df['new_Annual_income'].median(),
            color='yellow', linestyle = '--')

sns.boxplot(df['new_Annual_income'],showmeans=True)

df['new_Annual_income'].fillna(int( df['new_Annual_income'].median()),inplace = True)
df.isnull().sum()

import missingno as msno
msno.matrix(df)

df = df.drop(['Type_Occupation','Annual_income'],axis = 1)

df.dropna(inplace= True)

df['Age'] = (df['Birthday_count']*-1)/365


df = pd.get_dummies(df[['Ind_ID', 'GENDER', 'Car_Owner', 'Propert_Owner', 'CHILDREN',
       'Type_Income', 'EDUCATION', 'Marital_status', 'Housing_type',
       'Birthday_count', 'Employed_days', 'Mobile_phone', 'Work_Phone',
       'Phone', 'EMAIL_ID', 'Family_Members', 'Credit_card_approval',
       'new_Annual_income','Age']])
     

df.tail()

CrosstabResult=pd.crosstab(index=df['GENDER'],columns=df['Credit_card_approval'])
print(CrosstabResult)
CrosstabResult.plot.bar(figsize=(7,4), rot=0)
plt.title()

CrosstabResult=pd.crosstab(index=df['CHILDREN'],columns=df['Credit_card_approval'])
print(CrosstabResult)
CrosstabResult.plot.bar(rot = 0)#0 is approved 1 is rejected

plt.figure(figsize=(10,7))
sns.barplot(x='GENDER', y='new_Annual_income', data=df, hue='Credit_card_approval', dodge=True, palette='viridis')


plt.figure(figsize=(14,7))
sns.barplot(x='EDUCATION', y='new_Annual_income', data=df, hue='Credit_card_approval', dodge=True, palette='viridis')

sns.barplot(x= 'Credit_card_approval',y='Age',hue = 'GENDER', data = df)\

df.columns

from sklearn.model_selection import train_test_split
xTrain, xTest, yTrain, yTest = train_test_split(X, Y,
                                               test_size=0.30,
                                               random_state=2)
     

# Import MinMaxScaler
from sklearn.preprocessing import MinMaxScaler

# Instantiate MinMaxScaler and use it to rescale X_train and X_test
scaler = MinMaxScaler(feature_range=(0,1))
rescaledX_train = scaler.fit_transform(xTrain)
rescaledX_test = scaler.fit_transform(xTest)

from sklearn.metrics import accuracy_score 
from sklearn.tree import DecisionTreeClassifier
from sklearn.neighbors import KNeighborsClassifier
from pandas import DataFrame
from xgboost import XGBClassifier
     

from sklearn.linear_model import LogisticRegression 
# Instantiate a LogisticRegression classifier with default parameter values
logreg = LogisticRegression()
logreg.fit(rescaledX_train, yTrain)

from sklearn import metrics
y_pred_test_logreg = logreg.predict(rescaledX_test)
y_pred_train_logreg = logreg.predict(rescaledX_train)

print("Test: Accuracy = ", logreg.score(rescaledX_test,yTest))
print("Train: Accuracy = ", logreg.score(rescaledX_train,yTrain))

confusion_matrix = metrics.confusion_matrix(yTest,y_pred_test_logreg)
print(confusion_matrix)

# import numpy
import numpy as np
error_rate = []
# searching k value upto  40
for i in range(1,40):
    # knn algorithm 
    knn = KNeighborsClassifier(n_neighbors=i)
    knn.fit(rescaledX_train, yTrain)
    # testing the model
    y_pred_test_knn = knn.predict(rescaledX_test)
    #training the model
    y_pred_train_knn = knn.predict(rescaledX_train)

    error_rate.append(np.mean(y_pred_test_knn != yTest))
# Configure and plot error rate over k values
plt.figure(figsize=(10,4))
plt.plot(range(1,40), error_rate, color='blue', linestyle='dashed', marker='o', markerfacecolor='red', markersize=10)
plt.title('Error Rate vs. K-Values')
plt.xlabel('K-Values')
plt.ylabel('Error Rate')

test_acc_knn = accuracy_score(yTest, y_pred_test_knn)
train_acc_knn = accuracy_score(yTrain,y_pred_train_knn)
print('Train score:',train_acc_knn,'Test score:',test_acc_knn)
print(i,'Train score:',train_acc_knn,'Test score:',test_acc_knn)

test_acc=[]
list_score=[]


for i in range(1, 10):
    dtc = DecisionTreeClassifier(max_depth = i ,random_state = 0)
    dtc.fit(xTrain, yTrain)
    train_pred = dtc.predict(xTrain)
    test_pred = dtc.predict(xTest)
    test_acc = accuracy_score(yTest, test_pred)
    train_acc = accuracy_score(yTrain, train_pred)
    print(i,'Train score:',train_acc,'Test score:',test_acc)
    list_score.append([i,accuracy_score(train_pred, yTrain),accuracy_score(test_pred, yTest)])



df2 = DataFrame (list_score,columns=['Depth','Train Accuracy','Test Accuracy'])
plt.plot(df2['Depth'],df2['Test Accuracy'],label='Test Accuracy')
plt.plot(df2['Depth'],df2['Train Accuracy'],label='Train Accuracy')
plt.xlabel('Depth')
plt.ylabel('Accuracy')
plt.legend()    


model = XGBClassifier()
model.fit(xTrain, yTrain)
y_pred_train_xg= model.predict(xTrain)
y_pred_test_xg = model.predict(xTest)
test_acc = accuracy_score(yTest, y_pred_test_xg)
train_acc = accuracy_score(yTrain, y_pred_train_xg)
print('Train score:',train_acc,'Test score:',test_acc)
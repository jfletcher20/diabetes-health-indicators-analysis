import pandas as pd

data = pd.read_csv("diabetes_binary_5050split_health_indicators_BRFSS2015.csv")

diabetes_0 = data[data['Diabetes_binary'] == 0]
diabetes_1 = data[data['Diabetes_binary'] == 1]

num_per_class = 2000 // 2

selected_0 = diabetes_0.sample(num_per_class)
selected_1 = diabetes_1.sample(num_per_class)

selected_data = pd.concat([selected_0, selected_1])

selected_data = selected_data.sample(frac=1).reset_index(drop=True)

selected_data.to_csv("selected_data.csv", index=False)

print("Selected data saved to selected_data.csv")

---
title: "How to classify text using SVM in C#"
date: "2014-10-19T19:34:07"
lastmod: "2020-07-26T14:48:26"
url: "/2014/10/svm-tutorial-classify-text-csharp/"
weight: 30
description: "In this svm tutorial I will show you how to train a SVM model in C# step by step. You will then use this model to classify unlabeled text."
---

# SVM Tutorial : Classify text in C#

In this tutorial I will show you how to classify text with SVM in C#.

The main steps to classify text in C# are:

1. Create a new project
2. Install the SVM package with Nuget
3. Prepare the data
4. Read the data
5. Generate a problem
6. Train the model
7. Predict

## Step 1: Create the Project

Create a new Console application.

![SVM Tutorial Csharp](/wp-content/uploads/2014/05/svm_tutorial_csharp_1.png "Create a new project")

## 

## Step 2: Install the SVM package with NuGet

In the solution explorer, right click on "References" and click on "Manage NuGet Packages..."

![svm tutorial csharp](/wp-content/uploads/2014/05/svm_tutorial_csharp_2.png "Install the nuget package")

Select "Online" and in the search box type "SVM".

![svm tutorial csharp 3](/wp-content/uploads/2014/05/svm_tutorial_csharp_3.png "Select the right package")

You should now see the **libsvm.net** package. Click on Install, and that's it !

There are several [libsvm implementations](http://www.csie.ntu.edu.tw/~cjlin/libsvm/ "libsvm website") in C#. We will use [libsvm.net](https://github.com/nicolaspanel/libsvm.net "libsvm.net library") because it is the more up to date and it is easily downloadable via NuGet.

## Step 3: Prepare the data

Every time you want to classify text, you will need to prepare your data. As this is a language agnostic process I created a different page for it :   [How to prepare your data for text classification ?](/text-classification-prepare-data/ "How to prepare your data for text classification ?")   Check it out before reading the remaining of this svm tutorial !

## Step 4: Read the data

The document-term matrix is saved as [a CSV file.](http://en.wikipedia.org/wiki/Comma-separated_values "CSV Definition")  
It can easily be read in C#.  
To do this we will use another Nuget package called [CsvReader](http://www.nuget.org/packages/CsvTools/1.0.10 "Csv Reader Nuget Package").

```csharp

            const string dataFilePath = @"D:\sunnyData.csv";
            var dataTable = DataTable.New.ReadCsv(dataFilePath);
            List<string> x = dataTable.Rows.Select(row => row["Text"]).ToList();
            double[] y = dataTable.Rows.Select(row => double.Parse(row["IsSunny"]))
                                       .ToArray();
```

We have loaded all the sentences in the **x** variable, and all the class (-1 or +1) in the **y** variable.

The following code generate the vocabulary:

```csharp

var vocabulary = x.SelectMany(GetWords).Distinct().OrderBy(word => word).ToList();
```

## Step 5: Generate a problem

Using the data, we are now able to generate a **svm_problem**.

This is an in-memory representation of the document-term matrix.

```csharp

            var problemBuilder = new TextClassificationProblemBuilder();
            var problem = problemBuilder.CreateProblem(x, y, vocabulary.ToList());
```

## Step 6: Create and train a SVM model

```csharp

const int C = 1;
var model = new C_SVC(problem, KernelHelper.LinearKernel(), C);
```

When the C_SVC object constructor is called, it immediately calls the Train() method.  
We use a [**linear kernel** because they are particularly good with textual data](/2014/10/svm-linear-kernel-good-text-classification/ "Linear Kernel: Why is it recommended for text classification ?").  
The C value is constant for now, but should be optimized for better results.

## Step 7: Predict

Once the model is trained, it can be used to make predictions. The main method for that is the **Predict** method which takes an array of svm_node as a parameter.

```csharp

            string userInput;
            _predictionDictionary = new Dictionary<int, string> { { -1, "Rainy" }, { 1, "Sunny" } };
            do
            {
                userInput = Console.ReadLine();
                var newX = TextClassificationProblemBuilder.CreateNode(userInput, vocabulary);

                var predictedY = model.Predict(newX);
                Console.WriteLine("The prediction is {0}", _predictionDictionary[(int)predictedY]);
                Console.WriteLine(new string('=', 50));
            } while (userInput != "quit");
```

## Summary of this SVM Tutorial

Congratulations ! You have trained a SVM model and used it to make prediction on unknown data.

If you are interested by learning how to classify text with other languages you can read:

- [How to classify text in R](/2014/11/svm-classify-text-r/ "SVM Tutorial: How to classify text in R")

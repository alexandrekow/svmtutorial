using System;
using System.Collections.Generic;
using System.Linq;
using DataAccess;
using libsvm;

namespace SVMTextClassifier
{
    class Program
    {
        private static Dictionary<int, string> _predictionDictionary;

        static void Main()
        {
            // STEP 4: Read the data
            const string dataFilePath = @"D:\MACHINE_LEARNING\SVM\Tutorial\sunnyData.csv"; 
            var dataTable = DataTable.New.ReadCsv(dataFilePath); 
            List<string> x = dataTable.Rows.Select(row => row["Text"]).ToList(); 
            double[] y = dataTable.Rows.Select(row => double.Parse(row["IsSunny"]))
                                       .ToArray();

            var vocabulary = x.SelectMany(GetWords).Distinct().OrderBy(word => word).ToList();
             
            var problemBuilder = new TextClassificationProblemBuilder(); 
            var problem = problemBuilder.CreateProblem(x, y, vocabulary.ToList());

            // If you want you can save this problem with : 
            // ProblemHelper.WriteProblem(@"D:\MACHINE_LEARNING\SVM\Tutorial\sunnyData.problem", problem);
            // And then load it again using:
            // var problem = ProblemHelper.ReadProblem(@"D:\MACHINE_LEARNING\SVM\Tutorial\sunnyData.problem");
             
            const int C = 1; 
            var model = new C_SVC(problem, KernelHelper.LinearKernel(), C);
         
          

            var accuracy = model.GetCrossValidationAccuracy(10);
            Console.Clear();
            Console.WriteLine(new string('=', 50));
            Console.WriteLine("Accuracy of the model is {0:P}", accuracy); 
            model.Export(string.Format(@"D:\MACHINE_LEARNING\SVM\Tutorial\model_{0}_accuracy.model", accuracy));

            Console.WriteLine(new string('=', 50));
            Console.WriteLine("The model is trained. \r\nEnter a sentence to make a prediction. (ex: sunny rainy sunny)");
            Console.WriteLine(new string('=', 50));

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

            Console.WriteLine(""); 
        }

        private static IEnumerable<string> GetWords(string x)
        {
            return x.Split(new[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries);
        }
    }
}

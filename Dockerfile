FROM python:3.7

RUN pip install joblib
RUN pip install tensorflow==2.9.1
RUN pip install tensorflow_decision_forests --upgrade
RUN pip install pandas
RUN pip install scipy
RUN pip install sklearn
RUN pip install matplotlib
RUN pip install numpy_ext
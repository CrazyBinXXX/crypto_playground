³
â
^
AssignVariableOp
resource
value"dtype"
dtypetype"
validate_shapebool( 
N
Cast	
x"SrcT	
y"DstT"
SrcTtype"
DstTtype"
Truncatebool( 
8
Const
output"dtype"
valuetensor"
dtypetype
.
Identity

input"T
output"T"	
Ttype
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
³
PartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
@
ReadVariableOp
resource
value"dtype"
dtypetype
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
?
Select
	condition

t"T
e"T
output"T"	
Ttype
H
ShardedFilename
basename	
shard

num_shards
filename
f
SimpleMLCreateModelResource
model_handle"
	containerstring "
shared_namestring 
á
SimpleMLInferenceOpWithHandle
numerical_features
boolean_features
categorical_int_features'
#categorical_set_int_features_values1
-categorical_set_int_features_row_splits_dim_1	1
-categorical_set_int_features_row_splits_dim_2	
model_handle
dense_predictions
dense_col_representation"
dense_output_dimint(0

#SimpleMLLoadModelFromPathWithHandle
model_handle
path" 
output_typeslist(string)
 "
file_prefixstring 
Á
StatefulPartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring ¨
@
StaticRegexFullMatch	
input

output
"
patternstring
m
StaticRegexReplace	
input

output"
patternstring"
rewritestring"
replace_globalbool(
÷
StridedSlice

input"T
begin"Index
end"Index
strides"Index
output"T"	
Ttype"
Indextype:
2	"

begin_maskint "
end_maskint "
ellipsis_maskint "
new_axis_maskint "
shrink_axis_maskint 
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 

VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshape"#
allowed_deviceslist(string)
 
9
VarIsInitializedOp
resource
is_initialized
"serve*2.9.12v2.9.0-18-gd8ce9f9c3018©
W
asset_path_initializerPlaceholder*
_output_shapes
: *
dtype0*
shape: 

VariableVarHandleOp*
_class
loc:@Variable*
_output_shapes
: *
dtype0*
shape: *
shared_name
Variable
a
)Variable/IsInitialized/VarIsInitializedOpVarIsInitializedOpVariable*
_output_shapes
: 
R
Variable/AssignAssignVariableOpVariableasset_path_initializer*
dtype0
]
Variable/Read/ReadVariableOpReadVariableOpVariable*
_output_shapes
: *
dtype0
Y
asset_path_initializer_1Placeholder*
_output_shapes
: *
dtype0*
shape: 


Variable_1VarHandleOp*
_class
loc:@Variable_1*
_output_shapes
: *
dtype0*
shape: *
shared_name
Variable_1
e
+Variable_1/IsInitialized/VarIsInitializedOpVarIsInitializedOp
Variable_1*
_output_shapes
: 
X
Variable_1/AssignAssignVariableOp
Variable_1asset_path_initializer_1*
dtype0
a
Variable_1/Read/ReadVariableOpReadVariableOp
Variable_1*
_output_shapes
: *
dtype0
Y
asset_path_initializer_2Placeholder*
_output_shapes
: *
dtype0*
shape: 


Variable_2VarHandleOp*
_class
loc:@Variable_2*
_output_shapes
: *
dtype0*
shape: *
shared_name
Variable_2
e
+Variable_2/IsInitialized/VarIsInitializedOpVarIsInitializedOp
Variable_2*
_output_shapes
: 
X
Variable_2/AssignAssignVariableOp
Variable_2asset_path_initializer_2*
dtype0
a
Variable_2/Read/ReadVariableOpReadVariableOp
Variable_2*
_output_shapes
: *
dtype0
Y
asset_path_initializer_3Placeholder*
_output_shapes
: *
dtype0*
shape: 


Variable_3VarHandleOp*
_class
loc:@Variable_3*
_output_shapes
: *
dtype0*
shape: *
shared_name
Variable_3
e
+Variable_3/IsInitialized/VarIsInitializedOpVarIsInitializedOp
Variable_3*
_output_shapes
: 
X
Variable_3/AssignAssignVariableOp
Variable_3asset_path_initializer_3*
dtype0
a
Variable_3/Read/ReadVariableOpReadVariableOp
Variable_3*
_output_shapes
: *
dtype0
Y
asset_path_initializer_4Placeholder*
_output_shapes
: *
dtype0*
shape: 


Variable_4VarHandleOp*
_class
loc:@Variable_4*
_output_shapes
: *
dtype0*
shape: *
shared_name
Variable_4
e
+Variable_4/IsInitialized/VarIsInitializedOpVarIsInitializedOp
Variable_4*
_output_shapes
: 
X
Variable_4/AssignAssignVariableOp
Variable_4asset_path_initializer_4*
dtype0
a
Variable_4/Read/ReadVariableOpReadVariableOp
Variable_4*
_output_shapes
: *
dtype0
v
false_positivesVarHandleOp*
_output_shapes
: *
dtype0*
shape:* 
shared_namefalse_positives
o
#false_positives/Read/ReadVariableOpReadVariableOpfalse_positives*
_output_shapes
:*
dtype0
t
true_positivesVarHandleOp*
_output_shapes
: *
dtype0*
shape:*
shared_nametrue_positives
m
"true_positives/Read/ReadVariableOpReadVariableOptrue_positives*
_output_shapes
:*
dtype0
^
countVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_namecount
W
count/Read/ReadVariableOpReadVariableOpcount*
_output_shapes
: *
dtype0
^
totalVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nametotal
W
total/Read/ReadVariableOpReadVariableOptotal*
_output_shapes
: *
dtype0
b
count_1VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	count_1
[
count_1/Read/ReadVariableOpReadVariableOpcount_1*
_output_shapes
: *
dtype0
b
total_1VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	total_1
[
total_1/Read/ReadVariableOpReadVariableOptotal_1*
_output_shapes
: *
dtype0

SimpleMLCreateModelResourceSimpleMLCreateModelResource*
_output_shapes
: *E
shared_name64simple_ml_model_72489b24-01ad-4623-9b67-2fe346e1b2c1
h

is_trainedVarHandleOp*
_output_shapes
: *
dtype0
*
shape: *
shared_name
is_trained
a
is_trained/Read/ReadVariableOpReadVariableOp
is_trained*
_output_shapes
: *
dtype0

e
ReadVariableOpReadVariableOp
Variable_4^Variable_4/Assign*
_output_shapes
: *
dtype0
­
StatefulPartitionedCallStatefulPartitionedCallReadVariableOpSimpleMLCreateModelResource*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 *#
fR
__inference_<lambda>_41953

NoOpNoOp^StatefulPartitionedCall^Variable/Assign^Variable_1/Assign^Variable_2/Assign^Variable_3/Assign^Variable_4/Assign
¾
ConstConst"/device:CPU:0*
_output_shapes
: *
dtype0*ù
valueïBì Bå
õ
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses
_default_save_signature
_learner_params
		_features

_is_trained
	optimizer
loss

_model
_build_normalized_inputs
call
call_get_leaves
yggdrasil_model_path_tensor

signatures*


0*
* 
* 
°
non_trainable_variables

layers
metrics
layer_regularization_losses
layer_metrics
	variables
trainable_variables
regularization_losses
__call__
_default_save_signature
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses*
6
trace_0
trace_1
trace_2
trace_3* 
6
trace_0
trace_1
trace_2
trace_3* 
* 
* 
* 
JD
VARIABLE_VALUE
is_trained&_is_trained/.ATTRIBUTES/VARIABLE_VALUE*
* 
* 
+
 _input_builder
!_compiled_model* 

"trace_0* 

#trace_0* 
* 

$trace_0* 

%serving_default* 


0*
* 

&0
'1
(2*
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
P
)_feature_name_to_idx
*	_init_ops
#+categorical_str_to_int_hashmaps* 
S
,_model_loader
-_create_resource
._initialize
/_destroy_resource* 
* 
* 
* 
* 
8
0	variables
1	keras_api
	2total
	3count*
H
4	variables
5	keras_api
	6total
	7count
8
_fn_kwargs*
[
9	variables
:	keras_api
;
thresholds
<true_positives
=false_positives*
* 
* 
* 
5
>_output_types
?
_all_files
@
_done_file* 

Atrace_0* 

Btrace_0* 

Ctrace_0* 

20
31*

0	variables*
UO
VARIABLE_VALUEtotal_14keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUE*
UO
VARIABLE_VALUEcount_14keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUE*

60
71*

4	variables*
SM
VARIABLE_VALUEtotal4keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUE*
SM
VARIABLE_VALUEcount4keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUE*
* 

<0
=1*

9	variables*
* 
e_
VARIABLE_VALUEtrue_positives=keras_api/metrics/2/true_positives/.ATTRIBUTES/VARIABLE_VALUE*
ga
VARIABLE_VALUEfalse_positives>keras_api/metrics/2/false_positives/.ATTRIBUTES/VARIABLE_VALUE*
* 
%
D0
E1
F2
G3
@4* 
* 
* 
* 
* 
* 
* 
* 
* 
t
serving_default_10_c_bullPlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0	*
shape:ÿÿÿÿÿÿÿÿÿ
z
serving_default_10_c_log_returnPlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0*
shape:ÿÿÿÿÿÿÿÿÿ
t
serving_default_30_c_bullPlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0	*
shape:ÿÿÿÿÿÿÿÿÿ
z
serving_default_30_c_log_returnPlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0*
shape:ÿÿÿÿÿÿÿÿÿ
t
serving_default_60_c_bullPlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0	*
shape:ÿÿÿÿÿÿÿÿÿ
z
serving_default_60_c_log_returnPlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0*
shape:ÿÿÿÿÿÿÿÿÿ
s
serving_default_alpha_12Placeholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0*
shape:ÿÿÿÿÿÿÿÿÿ
r
serving_default_alpha_6Placeholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0*
shape:ÿÿÿÿÿÿÿÿÿ
w
serving_default_bolling_bearPlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0	*
shape:ÿÿÿÿÿÿÿÿÿ
w
serving_default_bolling_bullPlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0	*
shape:ÿÿÿÿÿÿÿÿÿ
u
serving_default_c_relativePlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0*
shape:ÿÿÿÿÿÿÿÿÿ
u
serving_default_h_relativePlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0*
shape:ÿÿÿÿÿÿÿÿÿ
u
serving_default_l_relativePlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0*
shape:ÿÿÿÿÿÿÿÿÿ
v
serving_default_long_signalPlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0	*
shape:ÿÿÿÿÿÿÿÿÿ
u
serving_default_o_relativePlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0*
shape:ÿÿÿÿÿÿÿÿÿ
w
serving_default_short_signalPlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0	*
shape:ÿÿÿÿÿÿÿÿÿ
u
serving_default_trend_bearPlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0	*
shape:ÿÿÿÿÿÿÿÿÿ
u
serving_default_trend_bullPlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0	*
shape:ÿÿÿÿÿÿÿÿÿ
u
serving_default_v_relativePlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0*
shape:ÿÿÿÿÿÿÿÿÿ
w
serving_default_vol_too_highPlaceholder*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0	*
shape:ÿÿÿÿÿÿÿÿÿ

StatefulPartitionedCall_1StatefulPartitionedCallserving_default_10_c_bullserving_default_10_c_log_returnserving_default_30_c_bullserving_default_30_c_log_returnserving_default_60_c_bullserving_default_60_c_log_returnserving_default_alpha_12serving_default_alpha_6serving_default_bolling_bearserving_default_bolling_bullserving_default_c_relativeserving_default_h_relativeserving_default_l_relativeserving_default_long_signalserving_default_o_relativeserving_default_short_signalserving_default_trend_bearserving_default_trend_bullserving_default_v_relativeserving_default_vol_too_highSimpleMLCreateModelResource* 
Tin
2										*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 *,
f'R%
#__inference_signature_wrapper_41763
O
saver_filenamePlaceholder*
_output_shapes
: *
dtype0*
shape: 
ý
StatefulPartitionedCall_2StatefulPartitionedCallsaver_filenameis_trained/Read/ReadVariableOptotal_1/Read/ReadVariableOpcount_1/Read/ReadVariableOptotal/Read/ReadVariableOpcount/Read/ReadVariableOp"true_positives/Read/ReadVariableOp#false_positives/Read/ReadVariableOpConst*
Tin
2	
*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 *'
f"R 
__inference__traced_save_42039
ì
StatefulPartitionedCall_3StatefulPartitionedCallsaver_filename
is_trainedtotal_1count_1totalcounttrue_positivesfalse_positives*
Tin

2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 **
f%R#
!__inference__traced_restore_42070Î¶
 
¾
>__inference_gradient_boosted_trees_model_6_layer_call_fn_41376

c_bull	
c_log_return
c_bull_0	
c_log_return_0
c_bull_1	
c_log_return_1
alpha_12
alpha_6
bolling_bear	
bolling_bull	

c_relative

h_relative

l_relative
long_signal	

o_relative
short_signal	

trend_bear	

trend_bull	

v_relative
vol_too_high	
unknown
identity¢StatefulPartitionedCallâ
StatefulPartitionedCallStatefulPartitionedCallc_bullc_log_returnc_bull_0c_log_return_0c_bull_1c_log_return_1alpha_12alpha_6bolling_bearbolling_bull
c_relative
h_relative
l_relativelong_signal
o_relativeshort_signal
trend_bear
trend_bull
v_relativevol_too_highunknown* 
Tin
2										*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 *b
f]R[
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41371o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*Ã
_input_shapes±
®:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ: 22
StatefulPartitionedCallStatefulPartitionedCall:N J
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	10_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name10_c_log_return:NJ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	30_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name30_c_log_return:NJ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	60_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name60_c_log_return:MI
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
"
_user_specified_name
alpha_12:LH
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
!
_user_specified_name	alpha_6:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namebolling_bear:Q	M
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namebolling_bull:O
K
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
c_relative:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
h_relative:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
l_relative:PL
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
%
_user_specified_namelong_signal:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
o_relative:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_nameshort_signal:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
trend_bear:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
trend_bull:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
v_relative:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namevol_too_high
¨
»
__inference_<lambda>_41953
staticregexreplace_input>
:simple_ml_simplemlloadmodelfrompathwithhandle_model_handle
identity¢-simple_ml/SimpleMLLoadModelFromPathWithHandle
StaticRegexReplaceStaticRegexReplacestaticregexreplace_input*
_output_shapes
: *!
pattern12ffaccd42b043a1done*
rewrite æ
-simple_ml/SimpleMLLoadModelFromPathWithHandle#SimpleMLLoadModelFromPathWithHandle:simple_ml_simplemlloadmodelfrompathwithhandle_model_handleStaticRegexReplace:output:0*
_output_shapes
 *!
file_prefix12ffaccd42b043a1J
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  ?L
IdentityIdentityConst:output:0^NoOp*
T0*
_output_shapes
: v
NoOpNoOp.^simple_ml/SimpleMLLoadModelFromPathWithHandle*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes
: : 2^
-simple_ml/SimpleMLLoadModelFromPathWithHandle-simple_ml/SimpleMLLoadModelFromPathWithHandle: 

_output_shapes
: 
Ï)
º
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41371

inputs	
inputs_1
inputs_2	
inputs_3
inputs_4	
inputs_5
inputs_6
inputs_7
inputs_8	
inputs_9	
	inputs_10
	inputs_11
	inputs_12
	inputs_13	
	inputs_14
	inputs_15	
	inputs_16	
	inputs_17	
	inputs_18
	inputs_19	
inference_op_model_handle
identity¢inference_op¢
PartitionedCallPartitionedCallinputsinputs_1inputs_2inputs_3inputs_4inputs_5inputs_6inputs_7inputs_8inputs_9	inputs_10	inputs_11	inputs_12	inputs_13	inputs_14	inputs_15	inputs_16	inputs_17	inputs_18	inputs_19*
Tin
2										* 
Tout
2*
_collective_manager_ids
 *Â
_output_shapes¯
¬:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 *3
f.R,
*__inference__build_normalized_inputs_41252æ
stackPackPartitionedCall:output:0PartitionedCall:output:1PartitionedCall:output:2PartitionedCall:output:3PartitionedCall:output:4PartitionedCall:output:5PartitionedCall:output:6PartitionedCall:output:7PartitionedCall:output:8PartitionedCall:output:9PartitionedCall:output:10PartitionedCall:output:11PartitionedCall:output:12PartitionedCall:output:13PartitionedCall:output:14PartitionedCall:output:15PartitionedCall:output:16PartitionedCall:output:17PartitionedCall:output:18PartitionedCall:output:19*
N*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*

axisL
ConstConst*
_output_shapes
:  *
dtype0*
value
B  N
Const_1Const*
_output_shapes
:  *
dtype0*
value
B  X
RaggedConstant/valuesConst*
_output_shapes
: *
dtype0*
valueB ^
RaggedConstant/ConstConst*
_output_shapes
:*
dtype0	*
valueB	R `
RaggedConstant/Const_1Const*
_output_shapes
:*
dtype0	*
valueB	R ¡
inference_opSimpleMLInferenceOpWithHandlestack:output:0Const:output:0Const_1:output:0RaggedConstant/values:output:0RaggedConstant/Const:output:0RaggedConstant/Const_1:output:0inference_op_model_handle*-
_output_shapes
:ÿÿÿÿÿÿÿÿÿ:*
dense_output_dimd
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"       f
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       f
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      þ
strided_sliceStridedSlice inference_op:dense_predictions:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*

begin_mask*
end_maske
IdentityIdentitystrided_slice:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿU
NoOpNoOp^inference_op*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*Ã
_input_shapes±
®:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ: 2
inference_opinference_op:K G
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:K	G
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:K
G
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs
Ï)
º
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41479

inputs	
inputs_1
inputs_2	
inputs_3
inputs_4	
inputs_5
inputs_6
inputs_7
inputs_8	
inputs_9	
	inputs_10
	inputs_11
	inputs_12
	inputs_13	
	inputs_14
	inputs_15	
	inputs_16	
	inputs_17	
	inputs_18
	inputs_19	
inference_op_model_handle
identity¢inference_op¢
PartitionedCallPartitionedCallinputsinputs_1inputs_2inputs_3inputs_4inputs_5inputs_6inputs_7inputs_8inputs_9	inputs_10	inputs_11	inputs_12	inputs_13	inputs_14	inputs_15	inputs_16	inputs_17	inputs_18	inputs_19*
Tin
2										* 
Tout
2*
_collective_manager_ids
 *Â
_output_shapes¯
¬:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 *3
f.R,
*__inference__build_normalized_inputs_41252æ
stackPackPartitionedCall:output:0PartitionedCall:output:1PartitionedCall:output:2PartitionedCall:output:3PartitionedCall:output:4PartitionedCall:output:5PartitionedCall:output:6PartitionedCall:output:7PartitionedCall:output:8PartitionedCall:output:9PartitionedCall:output:10PartitionedCall:output:11PartitionedCall:output:12PartitionedCall:output:13PartitionedCall:output:14PartitionedCall:output:15PartitionedCall:output:16PartitionedCall:output:17PartitionedCall:output:18PartitionedCall:output:19*
N*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*

axisL
ConstConst*
_output_shapes
:  *
dtype0*
value
B  N
Const_1Const*
_output_shapes
:  *
dtype0*
value
B  X
RaggedConstant/valuesConst*
_output_shapes
: *
dtype0*
valueB ^
RaggedConstant/ConstConst*
_output_shapes
:*
dtype0	*
valueB	R `
RaggedConstant/Const_1Const*
_output_shapes
:*
dtype0	*
valueB	R ¡
inference_opSimpleMLInferenceOpWithHandlestack:output:0Const:output:0Const_1:output:0RaggedConstant/values:output:0RaggedConstant/Const:output:0RaggedConstant/Const_1:output:0inference_op_model_handle*-
_output_shapes
:ÿÿÿÿÿÿÿÿÿ:*
dense_output_dimd
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"       f
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       f
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      þ
strided_sliceStridedSlice inference_op:dense_predictions:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*

begin_mask*
end_maske
IdentityIdentitystrided_slice:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿU
NoOpNoOp^inference_op*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*Ã
_input_shapes±
®:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ: 2
inference_opinference_op:K G
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:K	G
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:K
G
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs
Ø
Ô
>__inference_gradient_boosted_trees_model_6_layer_call_fn_41789
inputs_10_c_bull	
inputs_10_c_log_return
inputs_30_c_bull	
inputs_30_c_log_return
inputs_60_c_bull	
inputs_60_c_log_return
inputs_alpha_12
inputs_alpha_6
inputs_bolling_bear	
inputs_bolling_bull	
inputs_c_relative
inputs_h_relative
inputs_l_relative
inputs_long_signal	
inputs_o_relative
inputs_short_signal	
inputs_trend_bear	
inputs_trend_bull	
inputs_v_relative
inputs_vol_too_high	
unknown
identity¢StatefulPartitionedCallø
StatefulPartitionedCallStatefulPartitionedCallinputs_10_c_bullinputs_10_c_log_returninputs_30_c_bullinputs_30_c_log_returninputs_60_c_bullinputs_60_c_log_returninputs_alpha_12inputs_alpha_6inputs_bolling_bearinputs_bolling_bullinputs_c_relativeinputs_h_relativeinputs_l_relativeinputs_long_signalinputs_o_relativeinputs_short_signalinputs_trend_bearinputs_trend_bullinputs_v_relativeinputs_vol_too_highunknown* 
Tin
2										*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 *b
f]R[
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41371o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*Ã
_input_shapes±
®:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ: 22
StatefulPartitionedCallStatefulPartitionedCall:U Q
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/10_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/10_c_log_return:UQ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/30_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/30_c_log_return:UQ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/60_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/60_c_log_return:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_nameinputs/alpha_12:SO
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
(
_user_specified_nameinputs/alpha_6:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/bolling_bear:X	T
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/bolling_bull:V
R
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/c_relative:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/h_relative:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/l_relative:WS
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
,
_user_specified_nameinputs/long_signal:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/o_relative:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/short_signal:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/trend_bear:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/trend_bull:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/v_relative:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/vol_too_high
û*
à
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41566

c_bull	
c_log_return
c_bull_0	
c_log_return_0
c_bull_1	
c_log_return_1
alpha_12
alpha_6
bolling_bear	
bolling_bull	

c_relative

h_relative

l_relative
long_signal	

o_relative
short_signal	

trend_bear	

trend_bull	

v_relative
vol_too_high	
inference_op_model_handle
identity¢inference_opÈ
PartitionedCallPartitionedCallc_bullc_log_returnc_bull_0c_log_return_0c_bull_1c_log_return_1alpha_12alpha_6bolling_bearbolling_bull
c_relative
h_relative
l_relativelong_signal
o_relativeshort_signal
trend_bear
trend_bull
v_relativevol_too_high*
Tin
2										* 
Tout
2*
_collective_manager_ids
 *Â
_output_shapes¯
¬:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 *3
f.R,
*__inference__build_normalized_inputs_41252æ
stackPackPartitionedCall:output:0PartitionedCall:output:1PartitionedCall:output:2PartitionedCall:output:3PartitionedCall:output:4PartitionedCall:output:5PartitionedCall:output:6PartitionedCall:output:7PartitionedCall:output:8PartitionedCall:output:9PartitionedCall:output:10PartitionedCall:output:11PartitionedCall:output:12PartitionedCall:output:13PartitionedCall:output:14PartitionedCall:output:15PartitionedCall:output:16PartitionedCall:output:17PartitionedCall:output:18PartitionedCall:output:19*
N*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*

axisL
ConstConst*
_output_shapes
:  *
dtype0*
value
B  N
Const_1Const*
_output_shapes
:  *
dtype0*
value
B  X
RaggedConstant/valuesConst*
_output_shapes
: *
dtype0*
valueB ^
RaggedConstant/ConstConst*
_output_shapes
:*
dtype0	*
valueB	R `
RaggedConstant/Const_1Const*
_output_shapes
:*
dtype0	*
valueB	R ¡
inference_opSimpleMLInferenceOpWithHandlestack:output:0Const:output:0Const_1:output:0RaggedConstant/values:output:0RaggedConstant/Const:output:0RaggedConstant/Const_1:output:0inference_op_model_handle*-
_output_shapes
:ÿÿÿÿÿÿÿÿÿ:*
dense_output_dimd
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"       f
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       f
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      þ
strided_sliceStridedSlice inference_op:dense_predictions:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*

begin_mask*
end_maske
IdentityIdentitystrided_slice:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿU
NoOpNoOp^inference_op*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*Ã
_input_shapes±
®:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ: 2
inference_opinference_op:N J
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	10_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name10_c_log_return:NJ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	30_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name30_c_log_return:NJ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	60_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name60_c_log_return:MI
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
"
_user_specified_name
alpha_12:LH
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
!
_user_specified_name	alpha_6:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namebolling_bear:Q	M
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namebolling_bull:O
K
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
c_relative:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
h_relative:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
l_relative:PL
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
%
_user_specified_namelong_signal:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
o_relative:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_nameshort_signal:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
trend_bear:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
trend_bull:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
v_relative:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namevol_too_high
ð-
³
__inference_call_41730
inputs_10_c_bull	
inputs_10_c_log_return
inputs_30_c_bull	
inputs_30_c_log_return
inputs_60_c_bull	
inputs_60_c_log_return
inputs_alpha_12
inputs_alpha_6
inputs_bolling_bear	
inputs_bolling_bull	
inputs_c_relative
inputs_h_relative
inputs_l_relative
inputs_long_signal	
inputs_o_relative
inputs_short_signal	
inputs_trend_bear	
inputs_trend_bull	
inputs_v_relative
inputs_vol_too_high	
inference_op_model_handle
identity¢inference_opÞ
PartitionedCallPartitionedCallinputs_10_c_bullinputs_10_c_log_returninputs_30_c_bullinputs_30_c_log_returninputs_60_c_bullinputs_60_c_log_returninputs_alpha_12inputs_alpha_6inputs_bolling_bearinputs_bolling_bullinputs_c_relativeinputs_h_relativeinputs_l_relativeinputs_long_signalinputs_o_relativeinputs_short_signalinputs_trend_bearinputs_trend_bullinputs_v_relativeinputs_vol_too_high*
Tin
2										* 
Tout
2*
_collective_manager_ids
 *Â
_output_shapes¯
¬:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 *3
f.R,
*__inference__build_normalized_inputs_41252æ
stackPackPartitionedCall:output:0PartitionedCall:output:1PartitionedCall:output:2PartitionedCall:output:3PartitionedCall:output:4PartitionedCall:output:5PartitionedCall:output:6PartitionedCall:output:7PartitionedCall:output:8PartitionedCall:output:9PartitionedCall:output:10PartitionedCall:output:11PartitionedCall:output:12PartitionedCall:output:13PartitionedCall:output:14PartitionedCall:output:15PartitionedCall:output:16PartitionedCall:output:17PartitionedCall:output:18PartitionedCall:output:19*
N*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*

axisL
ConstConst*
_output_shapes
:  *
dtype0*
value
B  N
Const_1Const*
_output_shapes
:  *
dtype0*
value
B  X
RaggedConstant/valuesConst*
_output_shapes
: *
dtype0*
valueB ^
RaggedConstant/ConstConst*
_output_shapes
:*
dtype0	*
valueB	R `
RaggedConstant/Const_1Const*
_output_shapes
:*
dtype0	*
valueB	R ¡
inference_opSimpleMLInferenceOpWithHandlestack:output:0Const:output:0Const_1:output:0RaggedConstant/values:output:0RaggedConstant/Const:output:0RaggedConstant/Const_1:output:0inference_op_model_handle*-
_output_shapes
:ÿÿÿÿÿÿÿÿÿ:*
dense_output_dimd
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"       f
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       f
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      þ
strided_sliceStridedSlice inference_op:dense_predictions:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*

begin_mask*
end_maske
IdentityIdentitystrided_slice:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿU
NoOpNoOp^inference_op*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*Ã
_input_shapes±
®:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ: 2
inference_opinference_op:U Q
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/10_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/10_c_log_return:UQ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/30_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/30_c_log_return:UQ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/60_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/60_c_log_return:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_nameinputs/alpha_12:SO
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
(
_user_specified_nameinputs/alpha_6:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/bolling_bear:X	T
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/bolling_bull:V
R
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/c_relative:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/h_relative:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/l_relative:WS
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
,
_user_specified_nameinputs/long_signal:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/o_relative:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/short_signal:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/trend_bear:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/trend_bull:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/v_relative:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/vol_too_high
©
¿
__inference__initializer_41940
staticregexreplace_input>
:simple_ml_simplemlloadmodelfrompathwithhandle_model_handle
identity¢-simple_ml/SimpleMLLoadModelFromPathWithHandle
StaticRegexReplaceStaticRegexReplacestaticregexreplace_input*
_output_shapes
: *!
pattern12ffaccd42b043a1done*
rewrite æ
-simple_ml/SimpleMLLoadModelFromPathWithHandle#SimpleMLLoadModelFromPathWithHandle:simple_ml_simplemlloadmodelfrompathwithhandle_model_handleStaticRegexReplace:output:0*
_output_shapes
 *!
file_prefix12ffaccd42b043a1G
ConstConst*
_output_shapes
: *
dtype0*
value	B :L
IdentityIdentityConst:output:0^NoOp*
T0*
_output_shapes
: v
NoOpNoOp.^simple_ml/SimpleMLLoadModelFromPathWithHandle*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes
: : 2^
-simple_ml/SimpleMLLoadModelFromPathWithHandle-simple_ml/SimpleMLLoadModelFromPathWithHandle: 

_output_shapes
: 
´
Ü
 __inference__wrapped_model_41292

c_bull	
c_log_return
c_bull_0	
c_log_return_0
c_bull_1	
c_log_return_1
alpha_12
alpha_6
bolling_bear	
bolling_bull	

c_relative

h_relative

l_relative
long_signal	

o_relative
short_signal	

trend_bear	

trend_bull	

v_relative
vol_too_high	(
$gradient_boosted_trees_model_6_41288
identity¢6gradient_boosted_trees_model_6/StatefulPartitionedCallÛ
6gradient_boosted_trees_model_6/StatefulPartitionedCallStatefulPartitionedCallc_bullc_log_returnc_bull_0c_log_return_0c_bull_1c_log_return_1alpha_12alpha_6bolling_bearbolling_bull
c_relative
h_relative
l_relativelong_signal
o_relativeshort_signal
trend_bear
trend_bull
v_relativevol_too_high$gradient_boosted_trees_model_6_41288* 
Tin
2										*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 *
fR
__inference_call_41287
IdentityIdentity?gradient_boosted_trees_model_6/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
NoOpNoOp7^gradient_boosted_trees_model_6/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*Ã
_input_shapes±
®:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ: 2p
6gradient_boosted_trees_model_6/StatefulPartitionedCall6gradient_boosted_trees_model_6/StatefulPartitionedCall:N J
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	10_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name10_c_log_return:NJ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	30_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name30_c_log_return:NJ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	60_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name60_c_log_return:MI
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
"
_user_specified_name
alpha_12:LH
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
!
_user_specified_name	alpha_6:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namebolling_bear:Q	M
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namebolling_bull:O
K
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
c_relative:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
h_relative:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
l_relative:PL
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
%
_user_specified_namelong_signal:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
o_relative:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_nameshort_signal:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
trend_bear:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
trend_bull:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
v_relative:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namevol_too_high
Å

__inference__traced_save_42039
file_prefix)
%savev2_is_trained_read_readvariableop
&
"savev2_total_1_read_readvariableop&
"savev2_count_1_read_readvariableop$
 savev2_total_read_readvariableop$
 savev2_count_read_readvariableop-
)savev2_true_positives_read_readvariableop.
*savev2_false_positives_read_readvariableop
savev2_const

identity_1¢MergeV2Checkpointsw
StaticRegexFullMatchStaticRegexFullMatchfile_prefix"/device:CPU:**
_output_shapes
: *
pattern
^s3://.*Z
ConstConst"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B.parta
Const_1Const"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B
_temp/part
SelectSelectStaticRegexFullMatch:output:0Const:output:0Const_1:output:0"/device:CPU:**
T0*
_output_shapes
: f

StringJoin
StringJoinfile_prefixSelect:output:0"/device:CPU:**
N*
_output_shapes
: L

num_shardsConst*
_output_shapes
: *
dtype0*
value	B :f
ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
dtype0*
value	B : 
ShardedFilenameShardedFilenameStringJoin:output:0ShardedFilename/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: 
SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*²
value¨B¥B&_is_trained/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUEB=keras_api/metrics/2/true_positives/.ATTRIBUTES/VARIABLE_VALUEB>keras_api/metrics/2/false_positives/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH}
SaveV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*#
valueBB B B B B B B B Á
SaveV2SaveV2ShardedFilename:filename:0SaveV2/tensor_names:output:0 SaveV2/shape_and_slices:output:0%savev2_is_trained_read_readvariableop"savev2_total_1_read_readvariableop"savev2_count_1_read_readvariableop savev2_total_read_readvariableop savev2_count_read_readvariableop)savev2_true_positives_read_readvariableop*savev2_false_positives_read_readvariableopsavev2_const"/device:CPU:0*
_output_shapes
 *
dtypes

2

&MergeV2Checkpoints/checkpoint_prefixesPackShardedFilename:filename:0^SaveV2"/device:CPU:0*
N*
T0*
_output_shapes
:
MergeV2CheckpointsMergeV2Checkpoints/MergeV2Checkpoints/checkpoint_prefixes:output:0file_prefix"/device:CPU:0*
_output_shapes
 f
IdentityIdentityfile_prefix^MergeV2Checkpoints"/device:CPU:0*
T0*
_output_shapes
: Q

Identity_1IdentityIdentity:output:0^NoOp*
T0*
_output_shapes
: [
NoOpNoOp^MergeV2Checkpoints*"
_acd_function_control_output(*
_output_shapes
 "!

identity_1Identity_1:output:0*-
_input_shapes
: : : : : : ::: 2(
MergeV2CheckpointsMergeV2Checkpoints:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix:

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: : 

_output_shapes
:: 

_output_shapes
::

_output_shapes
: 
Ê
ö
!__inference__traced_restore_42070
file_prefix%
assignvariableop_is_trained:
 $
assignvariableop_1_total_1: $
assignvariableop_2_count_1: "
assignvariableop_3_total: "
assignvariableop_4_count: /
!assignvariableop_5_true_positives:0
"assignvariableop_6_false_positives:

identity_8¢AssignVariableOp¢AssignVariableOp_1¢AssignVariableOp_2¢AssignVariableOp_3¢AssignVariableOp_4¢AssignVariableOp_5¢AssignVariableOp_6
RestoreV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*²
value¨B¥B&_is_trained/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUEB=keras_api/metrics/2/true_positives/.ATTRIBUTES/VARIABLE_VALUEB>keras_api/metrics/2/false_positives/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH
RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*#
valueBB B B B B B B B Æ
	RestoreV2	RestoreV2file_prefixRestoreV2/tensor_names:output:0#RestoreV2/shape_and_slices:output:0"/device:CPU:0*4
_output_shapes"
 ::::::::*
dtypes

2
[
IdentityIdentityRestoreV2:tensors:0"/device:CPU:0*
T0
*
_output_shapes
:
AssignVariableOpAssignVariableOpassignvariableop_is_trainedIdentity:output:0"/device:CPU:0*
_output_shapes
 *
dtype0
]

Identity_1IdentityRestoreV2:tensors:1"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_1AssignVariableOpassignvariableop_1_total_1Identity_1:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_2IdentityRestoreV2:tensors:2"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_2AssignVariableOpassignvariableop_2_count_1Identity_2:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_3IdentityRestoreV2:tensors:3"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_3AssignVariableOpassignvariableop_3_totalIdentity_3:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_4IdentityRestoreV2:tensors:4"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_4AssignVariableOpassignvariableop_4_countIdentity_4:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_5IdentityRestoreV2:tensors:5"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_5AssignVariableOp!assignvariableop_5_true_positivesIdentity_5:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_6IdentityRestoreV2:tensors:6"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_6AssignVariableOp"assignvariableop_6_false_positivesIdentity_6:output:0"/device:CPU:0*
_output_shapes
 *
dtype01
NoOpNoOp"/device:CPU:0*
_output_shapes
 ë

Identity_7Identityfile_prefix^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_2^AssignVariableOp_3^AssignVariableOp_4^AssignVariableOp_5^AssignVariableOp_6^NoOp"/device:CPU:0*
T0*
_output_shapes
: U

Identity_8IdentityIdentity_7:output:0^NoOp_1*
T0*
_output_shapes
: Ù
NoOp_1NoOp^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_2^AssignVariableOp_3^AssignVariableOp_4^AssignVariableOp_5^AssignVariableOp_6*"
_acd_function_control_output(*
_output_shapes
 "!

identity_8Identity_8:output:0*#
_input_shapes
: : : : : : : : 2$
AssignVariableOpAssignVariableOp2(
AssignVariableOp_1AssignVariableOp_12(
AssignVariableOp_2AssignVariableOp_22(
AssignVariableOp_3AssignVariableOp_32(
AssignVariableOp_4AssignVariableOp_42(
AssignVariableOp_5AssignVariableOp_52(
AssignVariableOp_6AssignVariableOp_6:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix
-

*__inference__build_normalized_inputs_41252

inputs	
inputs_1
inputs_2	
inputs_3
inputs_4	
inputs_5
inputs_6
inputs_7
inputs_8	
inputs_9	
	inputs_10
	inputs_11
	inputs_12
	inputs_13	
	inputs_14
	inputs_15	
	inputs_16	
	inputs_17	
	inputs_18
	inputs_19	
identity

identity_1

identity_2

identity_3

identity_4

identity_5

identity_6

identity_7

identity_8

identity_9
identity_10
identity_11
identity_12
identity_13
identity_14
identity_15
identity_16
identity_17
identity_18
identity_19T
CastCast	inputs_19*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿV
Cast_1Cast	inputs_17*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿV
Cast_2Cast	inputs_16*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿS
Cast_3Castinputs*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿU
Cast_4Castinputs_2*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿU
Cast_5Castinputs_4*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿU
Cast_6Castinputs_9*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿU
Cast_7Castinputs_8*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿV
Cast_8Cast	inputs_13*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿV
Cast_9Cast	inputs_15*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿN
IdentityIdentity
Cast_3:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿN

Identity_1Identityinputs_1*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿP

Identity_2Identity
Cast_4:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿN

Identity_3Identityinputs_3*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿP

Identity_4Identity
Cast_5:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿN

Identity_5Identityinputs_5*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿN

Identity_6Identityinputs_6*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿN

Identity_7Identityinputs_7*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿP

Identity_8Identity
Cast_7:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿP

Identity_9Identity
Cast_6:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿP
Identity_10Identity	inputs_10*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿP
Identity_11Identity	inputs_11*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿP
Identity_12Identity	inputs_12*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿQ
Identity_13Identity
Cast_8:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿP
Identity_14Identity	inputs_14*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿQ
Identity_15Identity
Cast_9:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿQ
Identity_16Identity
Cast_2:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿQ
Identity_17Identity
Cast_1:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿP
Identity_18Identity	inputs_18*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿO
Identity_19IdentityCast:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ"
identityIdentity:output:0"!

identity_1Identity_1:output:0"#
identity_10Identity_10:output:0"#
identity_11Identity_11:output:0"#
identity_12Identity_12:output:0"#
identity_13Identity_13:output:0"#
identity_14Identity_14:output:0"#
identity_15Identity_15:output:0"#
identity_16Identity_16:output:0"#
identity_17Identity_17:output:0"#
identity_18Identity_18:output:0"#
identity_19Identity_19:output:0"!

identity_2Identity_2:output:0"!

identity_3Identity_3:output:0"!

identity_4Identity_4:output:0"!

identity_5Identity_5:output:0"!

identity_6Identity_6:output:0"!

identity_7Identity_7:output:0"!

identity_8Identity_8:output:0"!

identity_9Identity_9:output:0*(
_construction_contextkEagerRuntime*Á
_input_shapes¯
¬:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:K G
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:K	G
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:K
G
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs
 
¾
>__inference_gradient_boosted_trees_model_6_layer_call_fn_41510

c_bull	
c_log_return
c_bull_0	
c_log_return_0
c_bull_1	
c_log_return_1
alpha_12
alpha_6
bolling_bear	
bolling_bull	

c_relative

h_relative

l_relative
long_signal	

o_relative
short_signal	

trend_bear	

trend_bull	

v_relative
vol_too_high	
unknown
identity¢StatefulPartitionedCallâ
StatefulPartitionedCallStatefulPartitionedCallc_bullc_log_returnc_bull_0c_log_return_0c_bull_1c_log_return_1alpha_12alpha_6bolling_bearbolling_bull
c_relative
h_relative
l_relativelong_signal
o_relativeshort_signal
trend_bear
trend_bull
v_relativevol_too_highunknown* 
Tin
2										*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 *b
f]R[
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41479o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*Ã
_input_shapes±
®:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ: 22
StatefulPartitionedCallStatefulPartitionedCall:N J
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	10_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name10_c_log_return:NJ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	30_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name30_c_log_return:NJ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	60_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name60_c_log_return:MI
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
"
_user_specified_name
alpha_12:LH
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
!
_user_specified_name	alpha_6:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namebolling_bear:Q	M
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namebolling_bull:O
K
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
c_relative:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
h_relative:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
l_relative:PL
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
%
_user_specified_namelong_signal:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
o_relative:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_nameshort_signal:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
trend_bear:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
trend_bull:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
v_relative:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namevol_too_high
Ì
£
#__inference_signature_wrapper_41763

c_bull	
c_log_return
c_bull_0	
c_log_return_0
c_bull_1	
c_log_return_1
alpha_12
alpha_6
bolling_bear	
bolling_bull	

c_relative

h_relative

l_relative
long_signal	

o_relative
short_signal	

trend_bear	

trend_bull	

v_relative
vol_too_high	
unknown
identity¢StatefulPartitionedCall©
StatefulPartitionedCallStatefulPartitionedCallc_bullc_log_returnc_bull_0c_log_return_0c_bull_1c_log_return_1alpha_12alpha_6bolling_bearbolling_bull
c_relative
h_relative
l_relativelong_signal
o_relativeshort_signal
trend_bear
trend_bull
v_relativevol_too_highunknown* 
Tin
2										*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 *)
f$R"
 __inference__wrapped_model_41292o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*Ã
_input_shapes±
®:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ: 22
StatefulPartitionedCallStatefulPartitionedCall:N J
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	10_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name10_c_log_return:NJ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	30_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name30_c_log_return:NJ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	60_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name60_c_log_return:MI
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
"
_user_specified_name
alpha_12:LH
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
!
_user_specified_name	alpha_6:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namebolling_bear:Q	M
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namebolling_bull:O
K
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
c_relative:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
h_relative:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
l_relative:PL
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
%
_user_specified_namelong_signal:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
o_relative:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_nameshort_signal:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
trend_bear:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
trend_bull:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
v_relative:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namevol_too_high
³.
ö
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41871
inputs_10_c_bull	
inputs_10_c_log_return
inputs_30_c_bull	
inputs_30_c_log_return
inputs_60_c_bull	
inputs_60_c_log_return
inputs_alpha_12
inputs_alpha_6
inputs_bolling_bear	
inputs_bolling_bull	
inputs_c_relative
inputs_h_relative
inputs_l_relative
inputs_long_signal	
inputs_o_relative
inputs_short_signal	
inputs_trend_bear	
inputs_trend_bull	
inputs_v_relative
inputs_vol_too_high	
inference_op_model_handle
identity¢inference_opÞ
PartitionedCallPartitionedCallinputs_10_c_bullinputs_10_c_log_returninputs_30_c_bullinputs_30_c_log_returninputs_60_c_bullinputs_60_c_log_returninputs_alpha_12inputs_alpha_6inputs_bolling_bearinputs_bolling_bullinputs_c_relativeinputs_h_relativeinputs_l_relativeinputs_long_signalinputs_o_relativeinputs_short_signalinputs_trend_bearinputs_trend_bullinputs_v_relativeinputs_vol_too_high*
Tin
2										* 
Tout
2*
_collective_manager_ids
 *Â
_output_shapes¯
¬:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 *3
f.R,
*__inference__build_normalized_inputs_41252æ
stackPackPartitionedCall:output:0PartitionedCall:output:1PartitionedCall:output:2PartitionedCall:output:3PartitionedCall:output:4PartitionedCall:output:5PartitionedCall:output:6PartitionedCall:output:7PartitionedCall:output:8PartitionedCall:output:9PartitionedCall:output:10PartitionedCall:output:11PartitionedCall:output:12PartitionedCall:output:13PartitionedCall:output:14PartitionedCall:output:15PartitionedCall:output:16PartitionedCall:output:17PartitionedCall:output:18PartitionedCall:output:19*
N*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*

axisL
ConstConst*
_output_shapes
:  *
dtype0*
value
B  N
Const_1Const*
_output_shapes
:  *
dtype0*
value
B  X
RaggedConstant/valuesConst*
_output_shapes
: *
dtype0*
valueB ^
RaggedConstant/ConstConst*
_output_shapes
:*
dtype0	*
valueB	R `
RaggedConstant/Const_1Const*
_output_shapes
:*
dtype0	*
valueB	R ¡
inference_opSimpleMLInferenceOpWithHandlestack:output:0Const:output:0Const_1:output:0RaggedConstant/values:output:0RaggedConstant/Const:output:0RaggedConstant/Const_1:output:0inference_op_model_handle*-
_output_shapes
:ÿÿÿÿÿÿÿÿÿ:*
dense_output_dimd
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"       f
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       f
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      þ
strided_sliceStridedSlice inference_op:dense_predictions:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*

begin_mask*
end_maske
IdentityIdentitystrided_slice:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿU
NoOpNoOp^inference_op*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*Ã
_input_shapes±
®:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ: 2
inference_opinference_op:U Q
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/10_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/10_c_log_return:UQ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/30_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/30_c_log_return:UQ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/60_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/60_c_log_return:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_nameinputs/alpha_12:SO
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
(
_user_specified_nameinputs/alpha_6:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/bolling_bear:X	T
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/bolling_bull:V
R
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/c_relative:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/h_relative:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/l_relative:WS
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
,
_user_specified_nameinputs/long_signal:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/o_relative:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/short_signal:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/trend_bear:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/trend_bull:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/v_relative:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/vol_too_high
³.
ö
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41927
inputs_10_c_bull	
inputs_10_c_log_return
inputs_30_c_bull	
inputs_30_c_log_return
inputs_60_c_bull	
inputs_60_c_log_return
inputs_alpha_12
inputs_alpha_6
inputs_bolling_bear	
inputs_bolling_bull	
inputs_c_relative
inputs_h_relative
inputs_l_relative
inputs_long_signal	
inputs_o_relative
inputs_short_signal	
inputs_trend_bear	
inputs_trend_bull	
inputs_v_relative
inputs_vol_too_high	
inference_op_model_handle
identity¢inference_opÞ
PartitionedCallPartitionedCallinputs_10_c_bullinputs_10_c_log_returninputs_30_c_bullinputs_30_c_log_returninputs_60_c_bullinputs_60_c_log_returninputs_alpha_12inputs_alpha_6inputs_bolling_bearinputs_bolling_bullinputs_c_relativeinputs_h_relativeinputs_l_relativeinputs_long_signalinputs_o_relativeinputs_short_signalinputs_trend_bearinputs_trend_bullinputs_v_relativeinputs_vol_too_high*
Tin
2										* 
Tout
2*
_collective_manager_ids
 *Â
_output_shapes¯
¬:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 *3
f.R,
*__inference__build_normalized_inputs_41252æ
stackPackPartitionedCall:output:0PartitionedCall:output:1PartitionedCall:output:2PartitionedCall:output:3PartitionedCall:output:4PartitionedCall:output:5PartitionedCall:output:6PartitionedCall:output:7PartitionedCall:output:8PartitionedCall:output:9PartitionedCall:output:10PartitionedCall:output:11PartitionedCall:output:12PartitionedCall:output:13PartitionedCall:output:14PartitionedCall:output:15PartitionedCall:output:16PartitionedCall:output:17PartitionedCall:output:18PartitionedCall:output:19*
N*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*

axisL
ConstConst*
_output_shapes
:  *
dtype0*
value
B  N
Const_1Const*
_output_shapes
:  *
dtype0*
value
B  X
RaggedConstant/valuesConst*
_output_shapes
: *
dtype0*
valueB ^
RaggedConstant/ConstConst*
_output_shapes
:*
dtype0	*
valueB	R `
RaggedConstant/Const_1Const*
_output_shapes
:*
dtype0	*
valueB	R ¡
inference_opSimpleMLInferenceOpWithHandlestack:output:0Const:output:0Const_1:output:0RaggedConstant/values:output:0RaggedConstant/Const:output:0RaggedConstant/Const_1:output:0inference_op_model_handle*-
_output_shapes
:ÿÿÿÿÿÿÿÿÿ:*
dense_output_dimd
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"       f
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       f
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      þ
strided_sliceStridedSlice inference_op:dense_predictions:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*

begin_mask*
end_maske
IdentityIdentitystrided_slice:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿU
NoOpNoOp^inference_op*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*Ã
_input_shapes±
®:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ: 2
inference_opinference_op:U Q
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/10_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/10_c_log_return:UQ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/30_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/30_c_log_return:UQ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/60_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/60_c_log_return:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_nameinputs/alpha_12:SO
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
(
_user_specified_nameinputs/alpha_6:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/bolling_bear:X	T
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/bolling_bull:V
R
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/c_relative:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/h_relative:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/l_relative:WS
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
,
_user_specified_nameinputs/long_signal:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/o_relative:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/short_signal:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/trend_bear:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/trend_bull:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/v_relative:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/vol_too_high
)
÷
__inference_call_41287

inputs	
inputs_1
inputs_2	
inputs_3
inputs_4	
inputs_5
inputs_6
inputs_7
inputs_8	
inputs_9	
	inputs_10
	inputs_11
	inputs_12
	inputs_13	
	inputs_14
	inputs_15	
	inputs_16	
	inputs_17	
	inputs_18
	inputs_19	
inference_op_model_handle
identity¢inference_op¢
PartitionedCallPartitionedCallinputsinputs_1inputs_2inputs_3inputs_4inputs_5inputs_6inputs_7inputs_8inputs_9	inputs_10	inputs_11	inputs_12	inputs_13	inputs_14	inputs_15	inputs_16	inputs_17	inputs_18	inputs_19*
Tin
2										* 
Tout
2*
_collective_manager_ids
 *Â
_output_shapes¯
¬:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 *3
f.R,
*__inference__build_normalized_inputs_41252æ
stackPackPartitionedCall:output:0PartitionedCall:output:1PartitionedCall:output:2PartitionedCall:output:3PartitionedCall:output:4PartitionedCall:output:5PartitionedCall:output:6PartitionedCall:output:7PartitionedCall:output:8PartitionedCall:output:9PartitionedCall:output:10PartitionedCall:output:11PartitionedCall:output:12PartitionedCall:output:13PartitionedCall:output:14PartitionedCall:output:15PartitionedCall:output:16PartitionedCall:output:17PartitionedCall:output:18PartitionedCall:output:19*
N*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*

axisL
ConstConst*
_output_shapes
:  *
dtype0*
value
B  N
Const_1Const*
_output_shapes
:  *
dtype0*
value
B  X
RaggedConstant/valuesConst*
_output_shapes
: *
dtype0*
valueB ^
RaggedConstant/ConstConst*
_output_shapes
:*
dtype0	*
valueB	R `
RaggedConstant/Const_1Const*
_output_shapes
:*
dtype0	*
valueB	R ¡
inference_opSimpleMLInferenceOpWithHandlestack:output:0Const:output:0Const_1:output:0RaggedConstant/values:output:0RaggedConstant/Const:output:0RaggedConstant/Const_1:output:0inference_op_model_handle*-
_output_shapes
:ÿÿÿÿÿÿÿÿÿ:*
dense_output_dimd
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"       f
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       f
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      þ
strided_sliceStridedSlice inference_op:dense_predictions:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*

begin_mask*
end_maske
IdentityIdentitystrided_slice:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿU
NoOpNoOp^inference_op*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*Ã
_input_shapes±
®:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ: 2
inference_opinference_op:K G
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:K	G
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:K
G
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs:KG
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs
ÿ1
Ð
*__inference__build_normalized_inputs_41674
inputs_10_c_bull	
inputs_10_c_log_return
inputs_30_c_bull	
inputs_30_c_log_return
inputs_60_c_bull	
inputs_60_c_log_return
inputs_alpha_12
inputs_alpha_6
inputs_bolling_bear	
inputs_bolling_bull	
inputs_c_relative
inputs_h_relative
inputs_l_relative
inputs_long_signal	
inputs_o_relative
inputs_short_signal	
inputs_trend_bear	
inputs_trend_bull	
inputs_v_relative
inputs_vol_too_high	
identity

identity_1

identity_2

identity_3

identity_4

identity_5

identity_6

identity_7

identity_8

identity_9
identity_10
identity_11
identity_12
identity_13
identity_14
identity_15
identity_16
identity_17
identity_18
identity_19^
CastCastinputs_vol_too_high*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ^
Cast_1Castinputs_trend_bull*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ^
Cast_2Castinputs_trend_bear*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ]
Cast_3Castinputs_10_c_bull*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ]
Cast_4Castinputs_30_c_bull*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ]
Cast_5Castinputs_60_c_bull*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ`
Cast_6Castinputs_bolling_bull*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ`
Cast_7Castinputs_bolling_bear*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ_
Cast_8Castinputs_long_signal*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ`
Cast_9Castinputs_short_signal*

DstT0*

SrcT0	*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿN
IdentityIdentity
Cast_3:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ\

Identity_1Identityinputs_10_c_log_return*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿP

Identity_2Identity
Cast_4:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ\

Identity_3Identityinputs_30_c_log_return*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿP

Identity_4Identity
Cast_5:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ\

Identity_5Identityinputs_60_c_log_return*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿU

Identity_6Identityinputs_alpha_12*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿT

Identity_7Identityinputs_alpha_6*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿP

Identity_8Identity
Cast_7:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿP

Identity_9Identity
Cast_6:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿX
Identity_10Identityinputs_c_relative*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿX
Identity_11Identityinputs_h_relative*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿX
Identity_12Identityinputs_l_relative*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿQ
Identity_13Identity
Cast_8:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿX
Identity_14Identityinputs_o_relative*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿQ
Identity_15Identity
Cast_9:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿQ
Identity_16Identity
Cast_2:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿQ
Identity_17Identity
Cast_1:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿX
Identity_18Identityinputs_v_relative*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿO
Identity_19IdentityCast:y:0*
T0*#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ"
identityIdentity:output:0"!

identity_1Identity_1:output:0"#
identity_10Identity_10:output:0"#
identity_11Identity_11:output:0"#
identity_12Identity_12:output:0"#
identity_13Identity_13:output:0"#
identity_14Identity_14:output:0"#
identity_15Identity_15:output:0"#
identity_16Identity_16:output:0"#
identity_17Identity_17:output:0"#
identity_18Identity_18:output:0"#
identity_19Identity_19:output:0"!

identity_2Identity_2:output:0"!

identity_3Identity_3:output:0"!

identity_4Identity_4:output:0"!

identity_5Identity_5:output:0"!

identity_6Identity_6:output:0"!

identity_7Identity_7:output:0"!

identity_8Identity_8:output:0"!

identity_9Identity_9:output:0*(
_construction_contextkEagerRuntime*Á
_input_shapes¯
¬:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:U Q
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/10_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/10_c_log_return:UQ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/30_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/30_c_log_return:UQ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/60_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/60_c_log_return:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_nameinputs/alpha_12:SO
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
(
_user_specified_nameinputs/alpha_6:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/bolling_bear:X	T
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/bolling_bull:V
R
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/c_relative:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/h_relative:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/l_relative:WS
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
,
_user_specified_nameinputs/long_signal:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/o_relative:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/short_signal:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/trend_bear:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/trend_bull:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/v_relative:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/vol_too_high

,
__inference__destroyer_41945
identityG
ConstConst*
_output_shapes
: *
dtype0*
value	B :E
IdentityIdentityConst:output:0*
T0*
_output_shapes
: "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes 
Ø
Ô
>__inference_gradient_boosted_trees_model_6_layer_call_fn_41815
inputs_10_c_bull	
inputs_10_c_log_return
inputs_30_c_bull	
inputs_30_c_log_return
inputs_60_c_bull	
inputs_60_c_log_return
inputs_alpha_12
inputs_alpha_6
inputs_bolling_bear	
inputs_bolling_bull	
inputs_c_relative
inputs_h_relative
inputs_l_relative
inputs_long_signal	
inputs_o_relative
inputs_short_signal	
inputs_trend_bear	
inputs_trend_bull	
inputs_v_relative
inputs_vol_too_high	
unknown
identity¢StatefulPartitionedCallø
StatefulPartitionedCallStatefulPartitionedCallinputs_10_c_bullinputs_10_c_log_returninputs_30_c_bullinputs_30_c_log_returninputs_60_c_bullinputs_60_c_log_returninputs_alpha_12inputs_alpha_6inputs_bolling_bearinputs_bolling_bullinputs_c_relativeinputs_h_relativeinputs_l_relativeinputs_long_signalinputs_o_relativeinputs_short_signalinputs_trend_bearinputs_trend_bullinputs_v_relativeinputs_vol_too_highunknown* 
Tin
2										*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 *b
f]R[
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41479o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*Ã
_input_shapes±
®:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ: 22
StatefulPartitionedCallStatefulPartitionedCall:U Q
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/10_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/10_c_log_return:UQ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/30_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/30_c_log_return:UQ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
*
_user_specified_nameinputs/60_c_bull:[W
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
0
_user_specified_nameinputs/60_c_log_return:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_nameinputs/alpha_12:SO
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
(
_user_specified_nameinputs/alpha_6:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/bolling_bear:X	T
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/bolling_bull:V
R
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/c_relative:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/h_relative:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/l_relative:WS
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
,
_user_specified_nameinputs/long_signal:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/o_relative:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/short_signal:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/trend_bear:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/trend_bull:VR
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
+
_user_specified_nameinputs/v_relative:XT
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
-
_user_specified_nameinputs/vol_too_high
Ñ
K
__inference__creator_41932
identity¢SimpleMLCreateModelResource
SimpleMLCreateModelResourceSimpleMLCreateModelResource*
_output_shapes
: *E
shared_name64simple_ml_model_72489b24-01ad-4623-9b67-2fe346e1b2c1h
IdentityIdentity*SimpleMLCreateModelResource:model_handle:0^NoOp*
T0*
_output_shapes
: d
NoOpNoOp^SimpleMLCreateModelResource*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes 2:
SimpleMLCreateModelResourceSimpleMLCreateModelResource
û*
à
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41622

c_bull	
c_log_return
c_bull_0	
c_log_return_0
c_bull_1	
c_log_return_1
alpha_12
alpha_6
bolling_bear	
bolling_bull	

c_relative

h_relative

l_relative
long_signal	

o_relative
short_signal	

trend_bear	

trend_bull	

v_relative
vol_too_high	
inference_op_model_handle
identity¢inference_opÈ
PartitionedCallPartitionedCallc_bullc_log_returnc_bull_0c_log_return_0c_bull_1c_log_return_1alpha_12alpha_6bolling_bearbolling_bull
c_relative
h_relative
l_relativelong_signal
o_relativeshort_signal
trend_bear
trend_bull
v_relativevol_too_high*
Tin
2										* 
Tout
2*
_collective_manager_ids
 *Â
_output_shapes¯
¬:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8 *3
f.R,
*__inference__build_normalized_inputs_41252æ
stackPackPartitionedCall:output:0PartitionedCall:output:1PartitionedCall:output:2PartitionedCall:output:3PartitionedCall:output:4PartitionedCall:output:5PartitionedCall:output:6PartitionedCall:output:7PartitionedCall:output:8PartitionedCall:output:9PartitionedCall:output:10PartitionedCall:output:11PartitionedCall:output:12PartitionedCall:output:13PartitionedCall:output:14PartitionedCall:output:15PartitionedCall:output:16PartitionedCall:output:17PartitionedCall:output:18PartitionedCall:output:19*
N*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*

axisL
ConstConst*
_output_shapes
:  *
dtype0*
value
B  N
Const_1Const*
_output_shapes
:  *
dtype0*
value
B  X
RaggedConstant/valuesConst*
_output_shapes
: *
dtype0*
valueB ^
RaggedConstant/ConstConst*
_output_shapes
:*
dtype0	*
valueB	R `
RaggedConstant/Const_1Const*
_output_shapes
:*
dtype0	*
valueB	R ¡
inference_opSimpleMLInferenceOpWithHandlestack:output:0Const:output:0Const_1:output:0RaggedConstant/values:output:0RaggedConstant/Const:output:0RaggedConstant/Const_1:output:0inference_op_model_handle*-
_output_shapes
:ÿÿÿÿÿÿÿÿÿ:*
dense_output_dimd
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"       f
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       f
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      þ
strided_sliceStridedSlice inference_op:dense_predictions:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*

begin_mask*
end_maske
IdentityIdentitystrided_slice:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿU
NoOpNoOp^inference_op*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*Ã
_input_shapes±
®:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ:ÿÿÿÿÿÿÿÿÿ: 2
inference_opinference_op:N J
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	10_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name10_c_log_return:NJ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	30_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name30_c_log_return:NJ
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
#
_user_specified_name	60_c_bull:TP
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
)
_user_specified_name60_c_log_return:MI
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
"
_user_specified_name
alpha_12:LH
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
!
_user_specified_name	alpha_6:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namebolling_bear:Q	M
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namebolling_bull:O
K
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
c_relative:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
h_relative:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
l_relative:PL
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
%
_user_specified_namelong_signal:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
o_relative:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_nameshort_signal:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
trend_bear:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
trend_bull:OK
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
$
_user_specified_name
v_relative:QM
#
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
&
_user_specified_namevol_too_high
¾
[
-__inference_yggdrasil_model_path_tensor_41735
staticregexreplace_input
identity
StaticRegexReplaceStaticRegexReplacestaticregexreplace_input*
_output_shapes
: *!
pattern12ffaccd42b043a1done*
rewrite R
IdentityIdentityStaticRegexReplace:output:0*
T0*
_output_shapes
: "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes
: : 

_output_shapes
: "¿L
saver_filename:0StatefulPartitionedCall_2:0StatefulPartitionedCall_38"
saved_model_main_op

NoOp*>
__saved_model_init_op%#
__saved_model_init_op

NoOp*ü

serving_defaultè

;
	10_c_bull.
serving_default_10_c_bull:0	ÿÿÿÿÿÿÿÿÿ
G
10_c_log_return4
!serving_default_10_c_log_return:0ÿÿÿÿÿÿÿÿÿ
;
	30_c_bull.
serving_default_30_c_bull:0	ÿÿÿÿÿÿÿÿÿ
G
30_c_log_return4
!serving_default_30_c_log_return:0ÿÿÿÿÿÿÿÿÿ
;
	60_c_bull.
serving_default_60_c_bull:0	ÿÿÿÿÿÿÿÿÿ
G
60_c_log_return4
!serving_default_60_c_log_return:0ÿÿÿÿÿÿÿÿÿ
9
alpha_12-
serving_default_alpha_12:0ÿÿÿÿÿÿÿÿÿ
7
alpha_6,
serving_default_alpha_6:0ÿÿÿÿÿÿÿÿÿ
A
bolling_bear1
serving_default_bolling_bear:0	ÿÿÿÿÿÿÿÿÿ
A
bolling_bull1
serving_default_bolling_bull:0	ÿÿÿÿÿÿÿÿÿ
=

c_relative/
serving_default_c_relative:0ÿÿÿÿÿÿÿÿÿ
=

h_relative/
serving_default_h_relative:0ÿÿÿÿÿÿÿÿÿ
=

l_relative/
serving_default_l_relative:0ÿÿÿÿÿÿÿÿÿ
?
long_signal0
serving_default_long_signal:0	ÿÿÿÿÿÿÿÿÿ
=

o_relative/
serving_default_o_relative:0ÿÿÿÿÿÿÿÿÿ
A
short_signal1
serving_default_short_signal:0	ÿÿÿÿÿÿÿÿÿ
=

trend_bear/
serving_default_trend_bear:0	ÿÿÿÿÿÿÿÿÿ
=

trend_bull/
serving_default_trend_bull:0	ÿÿÿÿÿÿÿÿÿ
=

v_relative/
serving_default_v_relative:0ÿÿÿÿÿÿÿÿÿ
A
vol_too_high1
serving_default_vol_too_high:0	ÿÿÿÿÿÿÿÿÿ>
output_12
StatefulPartitionedCall_1:0ÿÿÿÿÿÿÿÿÿtensorflow/serving/predict2B

asset_path_initializer:0$12ffaccd42b043a1nodes-00000-of-0000129

asset_path_initializer_1:012ffaccd42b043a1header.pb2<

asset_path_initializer_2:012ffaccd42b043a1data_spec.pb2P

asset_path_initializer_3:0012ffaccd42b043a1gradient_boosted_trees_header.pb24

asset_path_initializer_4:012ffaccd42b043a1done:ÿÞ

	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses
_default_save_signature
_learner_params
		_features

_is_trained
	optimizer
loss

_model
_build_normalized_inputs
call
call_get_leaves
yggdrasil_model_path_tensor

signatures"
_tf_keras_model
'

0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
Ê
non_trainable_variables

layers
metrics
layer_regularization_losses
layer_metrics
	variables
trainable_variables
regularization_losses
__call__
_default_save_signature
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses"
_generic_user_object
¢
trace_0
trace_1
trace_2
trace_32·
>__inference_gradient_boosted_trees_model_6_layer_call_fn_41376
>__inference_gradient_boosted_trees_model_6_layer_call_fn_41789
>__inference_gradient_boosted_trees_model_6_layer_call_fn_41815
>__inference_gradient_boosted_trees_model_6_layer_call_fn_41510´
«²§
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults
p 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 ztrace_0ztrace_1ztrace_2ztrace_3

trace_0
trace_1
trace_2
trace_32£
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41871
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41927
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41566
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41622´
«²§
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults
p 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 ztrace_0ztrace_1ztrace_2ztrace_3
ÂB¿
 __inference__wrapped_model_41292	10_c_bull10_c_log_return	30_c_bull30_c_log_return	60_c_bull60_c_log_returnalpha_12alpha_6bolling_bearbolling_bull
c_relative
h_relative
l_relativelong_signal
o_relativeshort_signal
trend_bear
trend_bull
v_relativevol_too_high"
²
FullArgSpec
args 
varargsjargs
varkwjkwargs
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
:
 2
is_trained
"
	optimizer
 "
trackable_dict_wrapper
G
 _input_builder
!_compiled_model"
_generic_user_object
î
"trace_02Ñ
*__inference__build_normalized_inputs_41674¢
²
FullArgSpec
args
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 z"trace_0
ë
#trace_02Î
__inference_call_41730³
ª²¦
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults¢
p 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 z#trace_0
¨2¥¢
²
FullArgSpec
args
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 
è
$trace_02Ë
-__inference_yggdrasil_model_path_tensor_41735
²
FullArgSpec
args
jself
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *¢ z$trace_0
,
%serving_default"
signature_map
'

0"
trackable_list_wrapper
 "
trackable_list_wrapper
5
&0
'1
(2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
üBù
>__inference_gradient_boosted_trees_model_6_layer_call_fn_41376	10_c_bull10_c_log_return	30_c_bull30_c_log_return	60_c_bull60_c_log_returnalpha_12alpha_6bolling_bearbolling_bull
c_relative
h_relative
l_relativelong_signal
o_relativeshort_signal
trend_bear
trend_bull
v_relativevol_too_high"´
«²§
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults
p 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
B
>__inference_gradient_boosted_trees_model_6_layer_call_fn_41789inputs/10_c_bullinputs/10_c_log_returninputs/30_c_bullinputs/30_c_log_returninputs/60_c_bullinputs/60_c_log_returninputs/alpha_12inputs/alpha_6inputs/bolling_bearinputs/bolling_bullinputs/c_relativeinputs/h_relativeinputs/l_relativeinputs/long_signalinputs/o_relativeinputs/short_signalinputs/trend_bearinputs/trend_bullinputs/v_relativeinputs/vol_too_high"´
«²§
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults
p 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
B
>__inference_gradient_boosted_trees_model_6_layer_call_fn_41815inputs/10_c_bullinputs/10_c_log_returninputs/30_c_bullinputs/30_c_log_returninputs/60_c_bullinputs/60_c_log_returninputs/alpha_12inputs/alpha_6inputs/bolling_bearinputs/bolling_bullinputs/c_relativeinputs/h_relativeinputs/l_relativeinputs/long_signalinputs/o_relativeinputs/short_signalinputs/trend_bearinputs/trend_bullinputs/v_relativeinputs/vol_too_high"´
«²§
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults
p 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
üBù
>__inference_gradient_boosted_trees_model_6_layer_call_fn_41510	10_c_bull10_c_log_return	30_c_bull30_c_log_return	60_c_bull60_c_log_returnalpha_12alpha_6bolling_bearbolling_bull
c_relative
h_relative
l_relativelong_signal
o_relativeshort_signal
trend_bear
trend_bull
v_relativevol_too_high"´
«²§
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults
p 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
£B 
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41871inputs/10_c_bullinputs/10_c_log_returninputs/30_c_bullinputs/30_c_log_returninputs/60_c_bullinputs/60_c_log_returninputs/alpha_12inputs/alpha_6inputs/bolling_bearinputs/bolling_bullinputs/c_relativeinputs/h_relativeinputs/l_relativeinputs/long_signalinputs/o_relativeinputs/short_signalinputs/trend_bearinputs/trend_bullinputs/v_relativeinputs/vol_too_high"´
«²§
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults
p 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
£B 
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41927inputs/10_c_bullinputs/10_c_log_returninputs/30_c_bullinputs/30_c_log_returninputs/60_c_bullinputs/60_c_log_returninputs/alpha_12inputs/alpha_6inputs/bolling_bearinputs/bolling_bullinputs/c_relativeinputs/h_relativeinputs/l_relativeinputs/long_signalinputs/o_relativeinputs/short_signalinputs/trend_bearinputs/trend_bullinputs/v_relativeinputs/vol_too_high"´
«²§
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults
p 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
B
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41566	10_c_bull10_c_log_return	30_c_bull30_c_log_return	60_c_bull60_c_log_returnalpha_12alpha_6bolling_bearbolling_bull
c_relative
h_relative
l_relativelong_signal
o_relativeshort_signal
trend_bear
trend_bull
v_relativevol_too_high"´
«²§
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults
p 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
B
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41622	10_c_bull10_c_log_return	30_c_bull30_c_log_return	60_c_bull60_c_log_returnalpha_12alpha_6bolling_bearbolling_bull
c_relative
h_relative
l_relativelong_signal
o_relativeshort_signal
trend_bear
trend_bull
v_relativevol_too_high"´
«²§
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults
p 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
l
)_feature_name_to_idx
*	_init_ops
#+categorical_str_to_int_hashmaps"
_generic_user_object
S
,_model_loader
-_create_resource
._initialize
/_destroy_resourceR 
âBß
*__inference__build_normalized_inputs_41674inputs/10_c_bullinputs/10_c_log_returninputs/30_c_bullinputs/30_c_log_returninputs/60_c_bullinputs/60_c_log_returninputs/alpha_12inputs/alpha_6inputs/bolling_bearinputs/bolling_bullinputs/c_relativeinputs/h_relativeinputs/l_relativeinputs/long_signalinputs/o_relativeinputs/short_signalinputs/trend_bearinputs/trend_bullinputs/v_relativeinputs/vol_too_high"¢
²
FullArgSpec
args
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 
ßBÜ
__inference_call_41730inputs/10_c_bullinputs/10_c_log_returninputs/30_c_bullinputs/30_c_log_returninputs/60_c_bullinputs/60_c_log_returninputs/alpha_12inputs/alpha_6inputs/bolling_bearinputs/bolling_bullinputs/c_relativeinputs/h_relativeinputs/l_relativeinputs/long_signalinputs/o_relativeinputs/short_signalinputs/trend_bearinputs/trend_bullinputs/v_relativeinputs/vol_too_high"³
ª²¦
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults¢
p 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 
ÎBË
-__inference_yggdrasil_model_path_tensor_41735"
²
FullArgSpec
args
jself
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *¢ 
¿B¼
#__inference_signature_wrapper_41763	10_c_bull10_c_log_return	30_c_bull30_c_log_return	60_c_bull60_c_log_returnalpha_12alpha_6bolling_bearbolling_bull
c_relative
h_relative
l_relativelong_signal
o_relativeshort_signal
trend_bear
trend_bull
v_relativevol_too_high"
²
FullArgSpec
args 
varargs
 
varkwjkwargs
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 
N
0	variables
1	keras_api
	2total
	3count"
_tf_keras_metric
^
4	variables
5	keras_api
	6total
	7count
8
_fn_kwargs"
_tf_keras_metric
q
9	variables
:	keras_api
;
thresholds
<true_positives
=false_positives"
_tf_keras_metric
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
Q
>_output_types
?
_all_files
@
_done_file"
_generic_user_object
Ë
Atrace_02®
__inference__creator_41932
²
FullArgSpec
args 
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *¢ zAtrace_0
Ï
Btrace_02²
__inference__initializer_41940
²
FullArgSpec
args 
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *¢ zBtrace_0
Í
Ctrace_02°
__inference__destroyer_41945
²
FullArgSpec
args 
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *¢ zCtrace_0
.
20
31"
trackable_list_wrapper
-
0	variables"
_generic_user_object
:  (2total
:  (2count
.
60
71"
trackable_list_wrapper
-
4	variables"
_generic_user_object
:  (2total
:  (2count
 "
trackable_dict_wrapper
.
<0
=1"
trackable_list_wrapper
-
9	variables"
_generic_user_object
 "
trackable_list_wrapper
: (2true_positives
: (2false_positives
 "
trackable_list_wrapper
C
D0
E1
F2
G3
@4"
trackable_list_wrapper
*
±B®
__inference__creator_41932"
²
FullArgSpec
args 
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *¢ 
µB²
__inference__initializer_41940"
²
FullArgSpec
args 
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *¢ 
³B°
__inference__destroyer_41945"
²
FullArgSpec
args 
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *¢ 
*
*
*
* 
*__inference__build_normalized_inputs_41674í	¢ÿ
÷¢ó
ðªì
3
	10_c_bull&#
inputs/10_c_bullÿÿÿÿÿÿÿÿÿ	
?
10_c_log_return,)
inputs/10_c_log_returnÿÿÿÿÿÿÿÿÿ
3
	30_c_bull&#
inputs/30_c_bullÿÿÿÿÿÿÿÿÿ	
?
30_c_log_return,)
inputs/30_c_log_returnÿÿÿÿÿÿÿÿÿ
3
	60_c_bull&#
inputs/60_c_bullÿÿÿÿÿÿÿÿÿ	
?
60_c_log_return,)
inputs/60_c_log_returnÿÿÿÿÿÿÿÿÿ
1
alpha_12%"
inputs/alpha_12ÿÿÿÿÿÿÿÿÿ
/
alpha_6$!
inputs/alpha_6ÿÿÿÿÿÿÿÿÿ
9
bolling_bear)&
inputs/bolling_bearÿÿÿÿÿÿÿÿÿ	
9
bolling_bull)&
inputs/bolling_bullÿÿÿÿÿÿÿÿÿ	
5

c_relative'$
inputs/c_relativeÿÿÿÿÿÿÿÿÿ
5

h_relative'$
inputs/h_relativeÿÿÿÿÿÿÿÿÿ
5

l_relative'$
inputs/l_relativeÿÿÿÿÿÿÿÿÿ
7
long_signal(%
inputs/long_signalÿÿÿÿÿÿÿÿÿ	
5

o_relative'$
inputs/o_relativeÿÿÿÿÿÿÿÿÿ
9
short_signal)&
inputs/short_signalÿÿÿÿÿÿÿÿÿ	
5

trend_bear'$
inputs/trend_bearÿÿÿÿÿÿÿÿÿ	
5

trend_bull'$
inputs/trend_bullÿÿÿÿÿÿÿÿÿ	
5

v_relative'$
inputs/v_relativeÿÿÿÿÿÿÿÿÿ
9
vol_too_high)&
inputs/vol_too_highÿÿÿÿÿÿÿÿÿ	
ª "äªà
,
	10_c_bull
	10_c_bullÿÿÿÿÿÿÿÿÿ
8
10_c_log_return%"
10_c_log_returnÿÿÿÿÿÿÿÿÿ
,
	30_c_bull
	30_c_bullÿÿÿÿÿÿÿÿÿ
8
30_c_log_return%"
30_c_log_returnÿÿÿÿÿÿÿÿÿ
,
	60_c_bull
	60_c_bullÿÿÿÿÿÿÿÿÿ
8
60_c_log_return%"
60_c_log_returnÿÿÿÿÿÿÿÿÿ
*
alpha_12
alpha_12ÿÿÿÿÿÿÿÿÿ
(
alpha_6
alpha_6ÿÿÿÿÿÿÿÿÿ
2
bolling_bear"
bolling_bearÿÿÿÿÿÿÿÿÿ
2
bolling_bull"
bolling_bullÿÿÿÿÿÿÿÿÿ
.

c_relative 

c_relativeÿÿÿÿÿÿÿÿÿ
.

h_relative 

h_relativeÿÿÿÿÿÿÿÿÿ
.

l_relative 

l_relativeÿÿÿÿÿÿÿÿÿ
0
long_signal!
long_signalÿÿÿÿÿÿÿÿÿ
.

o_relative 

o_relativeÿÿÿÿÿÿÿÿÿ
2
short_signal"
short_signalÿÿÿÿÿÿÿÿÿ
.

trend_bear 

trend_bearÿÿÿÿÿÿÿÿÿ
.

trend_bull 

trend_bullÿÿÿÿÿÿÿÿÿ
.

v_relative 

v_relativeÿÿÿÿÿÿÿÿÿ
2
vol_too_high"
vol_too_highÿÿÿÿÿÿÿÿÿ6
__inference__creator_41932¢

¢ 
ª " 8
__inference__destroyer_41945¢

¢ 
ª " >
__inference__initializer_41940@!¢

¢ 
ª " ×
 __inference__wrapped_model_41292²!÷¢ó
ë¢ç
äªà
,
	10_c_bull
	10_c_bullÿÿÿÿÿÿÿÿÿ	
8
10_c_log_return%"
10_c_log_returnÿÿÿÿÿÿÿÿÿ
,
	30_c_bull
	30_c_bullÿÿÿÿÿÿÿÿÿ	
8
30_c_log_return%"
30_c_log_returnÿÿÿÿÿÿÿÿÿ
,
	60_c_bull
	60_c_bullÿÿÿÿÿÿÿÿÿ	
8
60_c_log_return%"
60_c_log_returnÿÿÿÿÿÿÿÿÿ
*
alpha_12
alpha_12ÿÿÿÿÿÿÿÿÿ
(
alpha_6
alpha_6ÿÿÿÿÿÿÿÿÿ
2
bolling_bear"
bolling_bearÿÿÿÿÿÿÿÿÿ	
2
bolling_bull"
bolling_bullÿÿÿÿÿÿÿÿÿ	
.

c_relative 

c_relativeÿÿÿÿÿÿÿÿÿ
.

h_relative 

h_relativeÿÿÿÿÿÿÿÿÿ
.

l_relative 

l_relativeÿÿÿÿÿÿÿÿÿ
0
long_signal!
long_signalÿÿÿÿÿÿÿÿÿ	
.

o_relative 

o_relativeÿÿÿÿÿÿÿÿÿ
2
short_signal"
short_signalÿÿÿÿÿÿÿÿÿ	
.

trend_bear 

trend_bearÿÿÿÿÿÿÿÿÿ	
.

trend_bull 

trend_bullÿÿÿÿÿÿÿÿÿ	
.

v_relative 

v_relativeÿÿÿÿÿÿÿÿÿ
2
vol_too_high"
vol_too_highÿÿÿÿÿÿÿÿÿ	
ª "3ª0
.
output_1"
output_1ÿÿÿÿÿÿÿÿÿÂ	
__inference_call_41730§	!	¢	
û¢÷
ðªì
3
	10_c_bull&#
inputs/10_c_bullÿÿÿÿÿÿÿÿÿ	
?
10_c_log_return,)
inputs/10_c_log_returnÿÿÿÿÿÿÿÿÿ
3
	30_c_bull&#
inputs/30_c_bullÿÿÿÿÿÿÿÿÿ	
?
30_c_log_return,)
inputs/30_c_log_returnÿÿÿÿÿÿÿÿÿ
3
	60_c_bull&#
inputs/60_c_bullÿÿÿÿÿÿÿÿÿ	
?
60_c_log_return,)
inputs/60_c_log_returnÿÿÿÿÿÿÿÿÿ
1
alpha_12%"
inputs/alpha_12ÿÿÿÿÿÿÿÿÿ
/
alpha_6$!
inputs/alpha_6ÿÿÿÿÿÿÿÿÿ
9
bolling_bear)&
inputs/bolling_bearÿÿÿÿÿÿÿÿÿ	
9
bolling_bull)&
inputs/bolling_bullÿÿÿÿÿÿÿÿÿ	
5

c_relative'$
inputs/c_relativeÿÿÿÿÿÿÿÿÿ
5

h_relative'$
inputs/h_relativeÿÿÿÿÿÿÿÿÿ
5

l_relative'$
inputs/l_relativeÿÿÿÿÿÿÿÿÿ
7
long_signal(%
inputs/long_signalÿÿÿÿÿÿÿÿÿ	
5

o_relative'$
inputs/o_relativeÿÿÿÿÿÿÿÿÿ
9
short_signal)&
inputs/short_signalÿÿÿÿÿÿÿÿÿ	
5

trend_bear'$
inputs/trend_bearÿÿÿÿÿÿÿÿÿ	
5

trend_bull'$
inputs/trend_bullÿÿÿÿÿÿÿÿÿ	
5

v_relative'$
inputs/v_relativeÿÿÿÿÿÿÿÿÿ
9
vol_too_high)&
inputs/vol_too_highÿÿÿÿÿÿÿÿÿ	
p 
ª "ÿÿÿÿÿÿÿÿÿ	
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41566¨!û¢÷
ï¢ë
äªà
,
	10_c_bull
	10_c_bullÿÿÿÿÿÿÿÿÿ	
8
10_c_log_return%"
10_c_log_returnÿÿÿÿÿÿÿÿÿ
,
	30_c_bull
	30_c_bullÿÿÿÿÿÿÿÿÿ	
8
30_c_log_return%"
30_c_log_returnÿÿÿÿÿÿÿÿÿ
,
	60_c_bull
	60_c_bullÿÿÿÿÿÿÿÿÿ	
8
60_c_log_return%"
60_c_log_returnÿÿÿÿÿÿÿÿÿ
*
alpha_12
alpha_12ÿÿÿÿÿÿÿÿÿ
(
alpha_6
alpha_6ÿÿÿÿÿÿÿÿÿ
2
bolling_bear"
bolling_bearÿÿÿÿÿÿÿÿÿ	
2
bolling_bull"
bolling_bullÿÿÿÿÿÿÿÿÿ	
.

c_relative 

c_relativeÿÿÿÿÿÿÿÿÿ
.

h_relative 

h_relativeÿÿÿÿÿÿÿÿÿ
.

l_relative 

l_relativeÿÿÿÿÿÿÿÿÿ
0
long_signal!
long_signalÿÿÿÿÿÿÿÿÿ	
.

o_relative 

o_relativeÿÿÿÿÿÿÿÿÿ
2
short_signal"
short_signalÿÿÿÿÿÿÿÿÿ	
.

trend_bear 

trend_bearÿÿÿÿÿÿÿÿÿ	
.

trend_bull 

trend_bullÿÿÿÿÿÿÿÿÿ	
.

v_relative 

v_relativeÿÿÿÿÿÿÿÿÿ
2
vol_too_high"
vol_too_highÿÿÿÿÿÿÿÿÿ	
p 
ª "%¢"

0ÿÿÿÿÿÿÿÿÿ
 	
Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41622¨!û¢÷
ï¢ë
äªà
,
	10_c_bull
	10_c_bullÿÿÿÿÿÿÿÿÿ	
8
10_c_log_return%"
10_c_log_returnÿÿÿÿÿÿÿÿÿ
,
	30_c_bull
	30_c_bullÿÿÿÿÿÿÿÿÿ	
8
30_c_log_return%"
30_c_log_returnÿÿÿÿÿÿÿÿÿ
,
	60_c_bull
	60_c_bullÿÿÿÿÿÿÿÿÿ	
8
60_c_log_return%"
60_c_log_returnÿÿÿÿÿÿÿÿÿ
*
alpha_12
alpha_12ÿÿÿÿÿÿÿÿÿ
(
alpha_6
alpha_6ÿÿÿÿÿÿÿÿÿ
2
bolling_bear"
bolling_bearÿÿÿÿÿÿÿÿÿ	
2
bolling_bull"
bolling_bullÿÿÿÿÿÿÿÿÿ	
.

c_relative 

c_relativeÿÿÿÿÿÿÿÿÿ
.

h_relative 

h_relativeÿÿÿÿÿÿÿÿÿ
.

l_relative 

l_relativeÿÿÿÿÿÿÿÿÿ
0
long_signal!
long_signalÿÿÿÿÿÿÿÿÿ	
.

o_relative 

o_relativeÿÿÿÿÿÿÿÿÿ
2
short_signal"
short_signalÿÿÿÿÿÿÿÿÿ	
.

trend_bear 

trend_bearÿÿÿÿÿÿÿÿÿ	
.

trend_bull 

trend_bullÿÿÿÿÿÿÿÿÿ	
.

v_relative 

v_relativeÿÿÿÿÿÿÿÿÿ
2
vol_too_high"
vol_too_highÿÿÿÿÿÿÿÿÿ	
p
ª "%¢"

0ÿÿÿÿÿÿÿÿÿ
 

Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41871´	!	¢	
û¢÷
ðªì
3
	10_c_bull&#
inputs/10_c_bullÿÿÿÿÿÿÿÿÿ	
?
10_c_log_return,)
inputs/10_c_log_returnÿÿÿÿÿÿÿÿÿ
3
	30_c_bull&#
inputs/30_c_bullÿÿÿÿÿÿÿÿÿ	
?
30_c_log_return,)
inputs/30_c_log_returnÿÿÿÿÿÿÿÿÿ
3
	60_c_bull&#
inputs/60_c_bullÿÿÿÿÿÿÿÿÿ	
?
60_c_log_return,)
inputs/60_c_log_returnÿÿÿÿÿÿÿÿÿ
1
alpha_12%"
inputs/alpha_12ÿÿÿÿÿÿÿÿÿ
/
alpha_6$!
inputs/alpha_6ÿÿÿÿÿÿÿÿÿ
9
bolling_bear)&
inputs/bolling_bearÿÿÿÿÿÿÿÿÿ	
9
bolling_bull)&
inputs/bolling_bullÿÿÿÿÿÿÿÿÿ	
5

c_relative'$
inputs/c_relativeÿÿÿÿÿÿÿÿÿ
5

h_relative'$
inputs/h_relativeÿÿÿÿÿÿÿÿÿ
5

l_relative'$
inputs/l_relativeÿÿÿÿÿÿÿÿÿ
7
long_signal(%
inputs/long_signalÿÿÿÿÿÿÿÿÿ	
5

o_relative'$
inputs/o_relativeÿÿÿÿÿÿÿÿÿ
9
short_signal)&
inputs/short_signalÿÿÿÿÿÿÿÿÿ	
5

trend_bear'$
inputs/trend_bearÿÿÿÿÿÿÿÿÿ	
5

trend_bull'$
inputs/trend_bullÿÿÿÿÿÿÿÿÿ	
5

v_relative'$
inputs/v_relativeÿÿÿÿÿÿÿÿÿ
9
vol_too_high)&
inputs/vol_too_highÿÿÿÿÿÿÿÿÿ	
p 
ª "%¢"

0ÿÿÿÿÿÿÿÿÿ
 

Y__inference_gradient_boosted_trees_model_6_layer_call_and_return_conditional_losses_41927´	!	¢	
û¢÷
ðªì
3
	10_c_bull&#
inputs/10_c_bullÿÿÿÿÿÿÿÿÿ	
?
10_c_log_return,)
inputs/10_c_log_returnÿÿÿÿÿÿÿÿÿ
3
	30_c_bull&#
inputs/30_c_bullÿÿÿÿÿÿÿÿÿ	
?
30_c_log_return,)
inputs/30_c_log_returnÿÿÿÿÿÿÿÿÿ
3
	60_c_bull&#
inputs/60_c_bullÿÿÿÿÿÿÿÿÿ	
?
60_c_log_return,)
inputs/60_c_log_returnÿÿÿÿÿÿÿÿÿ
1
alpha_12%"
inputs/alpha_12ÿÿÿÿÿÿÿÿÿ
/
alpha_6$!
inputs/alpha_6ÿÿÿÿÿÿÿÿÿ
9
bolling_bear)&
inputs/bolling_bearÿÿÿÿÿÿÿÿÿ	
9
bolling_bull)&
inputs/bolling_bullÿÿÿÿÿÿÿÿÿ	
5

c_relative'$
inputs/c_relativeÿÿÿÿÿÿÿÿÿ
5

h_relative'$
inputs/h_relativeÿÿÿÿÿÿÿÿÿ
5

l_relative'$
inputs/l_relativeÿÿÿÿÿÿÿÿÿ
7
long_signal(%
inputs/long_signalÿÿÿÿÿÿÿÿÿ	
5

o_relative'$
inputs/o_relativeÿÿÿÿÿÿÿÿÿ
9
short_signal)&
inputs/short_signalÿÿÿÿÿÿÿÿÿ	
5

trend_bear'$
inputs/trend_bearÿÿÿÿÿÿÿÿÿ	
5

trend_bull'$
inputs/trend_bullÿÿÿÿÿÿÿÿÿ	
5

v_relative'$
inputs/v_relativeÿÿÿÿÿÿÿÿÿ
9
vol_too_high)&
inputs/vol_too_highÿÿÿÿÿÿÿÿÿ	
p
ª "%¢"

0ÿÿÿÿÿÿÿÿÿ
 Þ
>__inference_gradient_boosted_trees_model_6_layer_call_fn_41376!û¢÷
ï¢ë
äªà
,
	10_c_bull
	10_c_bullÿÿÿÿÿÿÿÿÿ	
8
10_c_log_return%"
10_c_log_returnÿÿÿÿÿÿÿÿÿ
,
	30_c_bull
	30_c_bullÿÿÿÿÿÿÿÿÿ	
8
30_c_log_return%"
30_c_log_returnÿÿÿÿÿÿÿÿÿ
,
	60_c_bull
	60_c_bullÿÿÿÿÿÿÿÿÿ	
8
60_c_log_return%"
60_c_log_returnÿÿÿÿÿÿÿÿÿ
*
alpha_12
alpha_12ÿÿÿÿÿÿÿÿÿ
(
alpha_6
alpha_6ÿÿÿÿÿÿÿÿÿ
2
bolling_bear"
bolling_bearÿÿÿÿÿÿÿÿÿ	
2
bolling_bull"
bolling_bullÿÿÿÿÿÿÿÿÿ	
.

c_relative 

c_relativeÿÿÿÿÿÿÿÿÿ
.

h_relative 

h_relativeÿÿÿÿÿÿÿÿÿ
.

l_relative 

l_relativeÿÿÿÿÿÿÿÿÿ
0
long_signal!
long_signalÿÿÿÿÿÿÿÿÿ	
.

o_relative 

o_relativeÿÿÿÿÿÿÿÿÿ
2
short_signal"
short_signalÿÿÿÿÿÿÿÿÿ	
.

trend_bear 

trend_bearÿÿÿÿÿÿÿÿÿ	
.

trend_bull 

trend_bullÿÿÿÿÿÿÿÿÿ	
.

v_relative 

v_relativeÿÿÿÿÿÿÿÿÿ
2
vol_too_high"
vol_too_highÿÿÿÿÿÿÿÿÿ	
p 
ª "ÿÿÿÿÿÿÿÿÿÞ
>__inference_gradient_boosted_trees_model_6_layer_call_fn_41510!û¢÷
ï¢ë
äªà
,
	10_c_bull
	10_c_bullÿÿÿÿÿÿÿÿÿ	
8
10_c_log_return%"
10_c_log_returnÿÿÿÿÿÿÿÿÿ
,
	30_c_bull
	30_c_bullÿÿÿÿÿÿÿÿÿ	
8
30_c_log_return%"
30_c_log_returnÿÿÿÿÿÿÿÿÿ
,
	60_c_bull
	60_c_bullÿÿÿÿÿÿÿÿÿ	
8
60_c_log_return%"
60_c_log_returnÿÿÿÿÿÿÿÿÿ
*
alpha_12
alpha_12ÿÿÿÿÿÿÿÿÿ
(
alpha_6
alpha_6ÿÿÿÿÿÿÿÿÿ
2
bolling_bear"
bolling_bearÿÿÿÿÿÿÿÿÿ	
2
bolling_bull"
bolling_bullÿÿÿÿÿÿÿÿÿ	
.

c_relative 

c_relativeÿÿÿÿÿÿÿÿÿ
.

h_relative 

h_relativeÿÿÿÿÿÿÿÿÿ
.

l_relative 

l_relativeÿÿÿÿÿÿÿÿÿ
0
long_signal!
long_signalÿÿÿÿÿÿÿÿÿ	
.

o_relative 

o_relativeÿÿÿÿÿÿÿÿÿ
2
short_signal"
short_signalÿÿÿÿÿÿÿÿÿ	
.

trend_bear 

trend_bearÿÿÿÿÿÿÿÿÿ	
.

trend_bull 

trend_bullÿÿÿÿÿÿÿÿÿ	
.

v_relative 

v_relativeÿÿÿÿÿÿÿÿÿ
2
vol_too_high"
vol_too_highÿÿÿÿÿÿÿÿÿ	
p
ª "ÿÿÿÿÿÿÿÿÿê	
>__inference_gradient_boosted_trees_model_6_layer_call_fn_41789§	!	¢	
û¢÷
ðªì
3
	10_c_bull&#
inputs/10_c_bullÿÿÿÿÿÿÿÿÿ	
?
10_c_log_return,)
inputs/10_c_log_returnÿÿÿÿÿÿÿÿÿ
3
	30_c_bull&#
inputs/30_c_bullÿÿÿÿÿÿÿÿÿ	
?
30_c_log_return,)
inputs/30_c_log_returnÿÿÿÿÿÿÿÿÿ
3
	60_c_bull&#
inputs/60_c_bullÿÿÿÿÿÿÿÿÿ	
?
60_c_log_return,)
inputs/60_c_log_returnÿÿÿÿÿÿÿÿÿ
1
alpha_12%"
inputs/alpha_12ÿÿÿÿÿÿÿÿÿ
/
alpha_6$!
inputs/alpha_6ÿÿÿÿÿÿÿÿÿ
9
bolling_bear)&
inputs/bolling_bearÿÿÿÿÿÿÿÿÿ	
9
bolling_bull)&
inputs/bolling_bullÿÿÿÿÿÿÿÿÿ	
5

c_relative'$
inputs/c_relativeÿÿÿÿÿÿÿÿÿ
5

h_relative'$
inputs/h_relativeÿÿÿÿÿÿÿÿÿ
5

l_relative'$
inputs/l_relativeÿÿÿÿÿÿÿÿÿ
7
long_signal(%
inputs/long_signalÿÿÿÿÿÿÿÿÿ	
5

o_relative'$
inputs/o_relativeÿÿÿÿÿÿÿÿÿ
9
short_signal)&
inputs/short_signalÿÿÿÿÿÿÿÿÿ	
5

trend_bear'$
inputs/trend_bearÿÿÿÿÿÿÿÿÿ	
5

trend_bull'$
inputs/trend_bullÿÿÿÿÿÿÿÿÿ	
5

v_relative'$
inputs/v_relativeÿÿÿÿÿÿÿÿÿ
9
vol_too_high)&
inputs/vol_too_highÿÿÿÿÿÿÿÿÿ	
p 
ª "ÿÿÿÿÿÿÿÿÿê	
>__inference_gradient_boosted_trees_model_6_layer_call_fn_41815§	!	¢	
û¢÷
ðªì
3
	10_c_bull&#
inputs/10_c_bullÿÿÿÿÿÿÿÿÿ	
?
10_c_log_return,)
inputs/10_c_log_returnÿÿÿÿÿÿÿÿÿ
3
	30_c_bull&#
inputs/30_c_bullÿÿÿÿÿÿÿÿÿ	
?
30_c_log_return,)
inputs/30_c_log_returnÿÿÿÿÿÿÿÿÿ
3
	60_c_bull&#
inputs/60_c_bullÿÿÿÿÿÿÿÿÿ	
?
60_c_log_return,)
inputs/60_c_log_returnÿÿÿÿÿÿÿÿÿ
1
alpha_12%"
inputs/alpha_12ÿÿÿÿÿÿÿÿÿ
/
alpha_6$!
inputs/alpha_6ÿÿÿÿÿÿÿÿÿ
9
bolling_bear)&
inputs/bolling_bearÿÿÿÿÿÿÿÿÿ	
9
bolling_bull)&
inputs/bolling_bullÿÿÿÿÿÿÿÿÿ	
5

c_relative'$
inputs/c_relativeÿÿÿÿÿÿÿÿÿ
5

h_relative'$
inputs/h_relativeÿÿÿÿÿÿÿÿÿ
5

l_relative'$
inputs/l_relativeÿÿÿÿÿÿÿÿÿ
7
long_signal(%
inputs/long_signalÿÿÿÿÿÿÿÿÿ	
5

o_relative'$
inputs/o_relativeÿÿÿÿÿÿÿÿÿ
9
short_signal)&
inputs/short_signalÿÿÿÿÿÿÿÿÿ	
5

trend_bear'$
inputs/trend_bearÿÿÿÿÿÿÿÿÿ	
5

trend_bull'$
inputs/trend_bullÿÿÿÿÿÿÿÿÿ	
5

v_relative'$
inputs/v_relativeÿÿÿÿÿÿÿÿÿ
9
vol_too_high)&
inputs/vol_too_highÿÿÿÿÿÿÿÿÿ	
p
ª "ÿÿÿÿÿÿÿÿÿÓ
#__inference_signature_wrapper_41763«!ð¢ì
¢ 
äªà
,
	10_c_bull
	10_c_bullÿÿÿÿÿÿÿÿÿ	
8
10_c_log_return%"
10_c_log_returnÿÿÿÿÿÿÿÿÿ
,
	30_c_bull
	30_c_bullÿÿÿÿÿÿÿÿÿ	
8
30_c_log_return%"
30_c_log_returnÿÿÿÿÿÿÿÿÿ
,
	60_c_bull
	60_c_bullÿÿÿÿÿÿÿÿÿ	
8
60_c_log_return%"
60_c_log_returnÿÿÿÿÿÿÿÿÿ
*
alpha_12
alpha_12ÿÿÿÿÿÿÿÿÿ
(
alpha_6
alpha_6ÿÿÿÿÿÿÿÿÿ
2
bolling_bear"
bolling_bearÿÿÿÿÿÿÿÿÿ	
2
bolling_bull"
bolling_bullÿÿÿÿÿÿÿÿÿ	
.

c_relative 

c_relativeÿÿÿÿÿÿÿÿÿ
.

h_relative 

h_relativeÿÿÿÿÿÿÿÿÿ
.

l_relative 

l_relativeÿÿÿÿÿÿÿÿÿ
0
long_signal!
long_signalÿÿÿÿÿÿÿÿÿ	
.

o_relative 

o_relativeÿÿÿÿÿÿÿÿÿ
2
short_signal"
short_signalÿÿÿÿÿÿÿÿÿ	
.

trend_bear 

trend_bearÿÿÿÿÿÿÿÿÿ	
.

trend_bull 

trend_bullÿÿÿÿÿÿÿÿÿ	
.

v_relative 

v_relativeÿÿÿÿÿÿÿÿÿ
2
vol_too_high"
vol_too_highÿÿÿÿÿÿÿÿÿ	"3ª0
.
output_1"
output_1ÿÿÿÿÿÿÿÿÿL
-__inference_yggdrasil_model_path_tensor_41735@¢

¢ 
ª " 
# coding = utf-8
import paddle.v2 as paddle
import paddle.v2.dataset.uci_housing as uci_housing
paddle.init(use_gpu=False, trainer_count=1)

x = paddle.layer.data(name='x', type=paddle.data_type.dense_vector(13))
y_predict = paddle.layer.fc(input=x,
                                size=1,
                                act=paddle.activation.Linear())
y = paddle.layer.data(name='y', type=paddle.data_type.dense_vector(1))
cost = paddle.layer.square_error_cost(input=y_predict, label=y)

# Save the inference topology to protobuf.
inference_topology = paddle.topology.Topology(layers=y_predict)
with open("inference_topology.pkl", 'wb') as f:
    inference_topology.serialize_for_inference(f)

parameters = paddle.parameters.create(cost)

optimizer = paddle.optimizer.Momentum(momentum=0)

trainer = paddle.trainer.SGD(cost=cost,
                             parameters=parameters,
                             update_equation=optimizer)

feeding={'x': 0, 'y': 1}

# event_handler to print training and testing info
def event_handler(event):
    if isinstance(event, paddle.event.EndIteration):
        if event.batch_id % 100 == 0:
            print "Pass %d, Batch %d, Cost %f" % (
                event.pass_id, event.batch_id, event.cost)

    if isinstance(event, paddle.event.EndPass):
        result = trainer.test(
            reader=paddle.batch(
                uci_housing.test(), batch_size=2),
            feeding=feeding)
        print "Test %d, Cost %f" % (event.pass_id, result.cost)

# event_handler to plot training and testing info
from paddle.v2.plot import Ploter

train_title = "Train cost"
test_title = "Test cost"
plot_cost = Ploter(train_title, test_title)

step = 0

def event_handler_plot(event):
    global step
    if isinstance(event, paddle.event.EndIteration):
        if step % 10 == 0:  # every 10 batches, record a train cost
            plot_cost.append(train_title, step, event.cost)

        if step % 100 == 0: # every 100 batches, record a test cost
            result = trainer.test(
                reader=paddle.batch(
                    uci_housing.test(), batch_size=2),
                feeding=feeding)
            plot_cost.append(test_title, step, result.cost)

        if step % 100 == 0: # every 100 batches, update cost plot
            plot_cost.plot()

        step += 1

    if isinstance(event, paddle.event.EndPass):
        if event.pass_id % 10 == 0:
            with open('params_pass_%d.tar' % event.pass_id, 'w') as f:
                trainer.save_parameter_to_tar(f)


trainer.train(
    reader=paddle.batch(
        paddle.reader.shuffle(
            uci_housing.train(), buf_size=500),
        batch_size=2),
    feeding=feeding,
    event_handler=event_handler_plot,
    num_passes=30)


# Apply model
test_data_creator = paddle.dataset.uci_housing.test()
test_data = []
test_label = []

for item in test_data_creator():
    test_data.append((item[0],))
    test_label.append(item[1])
    if len(test_data) == 5:
        break

# load parameters from tar file.
# users can remove the comments and change the model name
# with open('params_pass_20.tar', 'r') as f:
#     parameters = paddle.parameters.Parameters.from_tar(f)

probs = paddle.infer(
    output_layer=y_predict, parameters=parameters, input=test_data)

for i in xrange(len(probs)):
    print "label=" + str(test_label[i][0]) + ", predict=" + str(probs[i][0])

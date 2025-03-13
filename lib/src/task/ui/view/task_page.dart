import 'package:flutter/material.dart';
import 'package:my_task_0/src/core/validators.dart';
import 'package:my_task_0/src/task/data/model/task_model.dart';
import 'package:my_task_0/src/task/ui/viewmodel/task_state.dart';
import 'package:my_task_0/src/task/ui/viewmodel/task_viewmodel.dart';

class TaskPage extends StatefulWidget {
  final TaskViewmodel taskViewmodel;
  const TaskPage({required this.taskViewmodel, super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with Validators {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.taskViewmodel.getTasksEvent();
  }

  @override
  void dispose() {
    super.dispose();
    widget.taskViewmodel.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: widget.taskViewmodel,
          builder: (_, state, __) {
            if (state is TaskError) {
              WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('mensagem de erro:'),
                      content: Text(state.message),
                      actions: [
                        ElevatedButton(
                            onPressed: Navigator.of(context).pop,
                            child: Text('Ok'))
                      ],
                    ),
                  );
                },
              );
            }

            if (state is TaskLoading) {
              return CircularProgressIndicator();
            }

            if (state is TaskSuccess) {
              return Column(
                children: [
                  Text('Minha lista de tarefas'),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              '${state.tasks[index].id} ${state.tasks[index].title}'),
                          subtitle: Text(state.tasks[index].description),
                          leading: Checkbox(
                            value: state.tasks[index].isDone,
                            onChanged: (value) {
                              widget.taskViewmodel.updateTaskEvent(
                                  task: state.tasks[index]
                                      .copyWith(isDone: value));
                            },
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                widget.taskViewmodel.deleteTaskEvent(
                                    id: state.tasks[index].id!);
                              },
                              icon: Icon(Icons.delete)),
                        );
                      },
                    ),
                  )
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.task),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Form(
                  key: keyForm,
                  child: Column(
                    children: [
                      Text('Preencha os campos para criar a tarefa'),
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(labelText: 'titulo'),
                        validator: titleValidator,
                      ),
                      TextFormField(
                        controller: descriptionController,
                        decoration: InputDecoration(labelText: 'descrição'),
                        validator: descriptionValidator,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (keyForm.currentState?.validate() ?? false) {
                              widget.taskViewmodel.createTaskEvent(
                                  task: TaskModel(
                                      title: titleController.text,
                                      description: descriptionController.text));
                              Navigator.of(context).pop();
                              titleController.clear();
                              descriptionController.clear();
                            }
                          },
                          child: Text('criar tarefa'))
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}

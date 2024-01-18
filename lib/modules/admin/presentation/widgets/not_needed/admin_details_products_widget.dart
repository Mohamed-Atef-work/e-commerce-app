/*class AdminProductsWidget extends StatelessWidget {
  const AdminProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.3,
      child: BlocBuilder<AdminDetailsCubit, AdminDetailsState>(
        buildWhen: (previous, current) =>
            previous.deleteState != current.deleteState,
        builder: (context, state) {
          if (state.deleteState == RequestState.loading) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              itemCount: state.products!.length,
              itemBuilder: (context, index) => ProductComponent(
                onTap: () {
                  BlocProvider.of<AdminDetailsCubit>(context)
                      .emitSelectedProduct(index);
                },
                name: state.products![index].name,
                image: state.products![index].image,
              ),
            );
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}*/

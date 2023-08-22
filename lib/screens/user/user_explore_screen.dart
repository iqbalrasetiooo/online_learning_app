import 'package:online_learning_app/export.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key, required Map<String, String> arguments});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool isSearch = false;
  String defaultImage =
      'https://images.unsplash.com/photo-1616587894289-86480e533129?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fHZpZGVvJTIwbGVhcm5pbmd8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60';
  @override
  void initState() {
    // TODO: implement initState
    refreshData();
    super.initState();
  }

  bool buttonSelected = false;
  TextEditingController searchController = TextEditingController();
  refreshData() {
    context.read<GetCourseBloc>().add(GetAllCourseEvent());
  }

  @override
  Widget build(BuildContext context) {
    selectedButtonCategory() {
      setState(() {
        buttonSelected = !buttonSelected;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cari Kursus',
                    style: blackTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 30.0),
              child: TextFormField(
                controller: searchController,
                onFieldSubmitted: (value) {
                  value = searchController.text;
                  if (value.isEmpty) {
                    refreshData();
                    isSearch = false;
                  } else {
                    isSearch = true;
                    context.read<SearchCourseBloc>().add(SearchCourseByQuery(query: value));
                  }
                  setState(() {});
                },
                onChanged: (value) {
                  // (value == "" || value.isEmpty) ? : true;
                  value = searchController.text;
                  if (value.isEmpty) {
                    refreshData();
                    isSearch = false;
                  } else {
                    isSearch = true;
                    context.read<SearchCourseBloc>().add(SearchCourseByQuery(query: value));
                  }
                  setState(() {});
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.search,
                autocorrect: false,
                style: blackTextStyle.copyWith(fontSize: 14, fontWeight: regular),
                cursorColor: kBlackColor,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                  hintText: 'Javascript Dasar..',
                  hintStyle: greyTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 0.5,
                      color: kGreyColor,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 20,
                    color: kGreyColor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                scrollDirection: Axis.vertical,
                children: [
                  const SizedBox(height: 32),
                  (isSearch == false)
                      ? BlocBuilder<GetCourseBloc, GetCourseState>(
                          builder: (context, state) {
                            if (state is GetCourseError) {
                              return Text(state.message);
                            } else if (state is GetCourseLoading) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is GetCourseSuccess) {
                              var dataLength = state.course.data!.length;
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: dataLength,
                                itemBuilder: (context, index) {
                                  var course = state.course.data![index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const JoinCourseScreen(),
                                          settings: RouteSettings(arguments: course),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 24),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // course.image == null ? Container()
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              image: DecorationImage(
                                                image: NetworkImage(defaultImage),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                course.title.toString(),
                                                style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                                              ),
                                              const SizedBox(height: 12),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                      course.description.toString(),
                                                      style: greyTextStyle.copyWith(fontSize: 12, fontWeight: regular),
                                                      overflow: TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      maxLines: 3,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 20),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Text('');
                            }
                          },
                        )
                      : BlocBuilder<SearchCourseBloc, SearchCourseState>(
                          builder: (context, state) {
                            if (state is SearchCourseLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is SearchCourseError) {
                              return Center(
                                child: Text('Error: ${state.message}'),
                              );
                            } else if (state is SearchCourseSuccess) {
                              var dataLength = state.result.data!.length;
                              return (state.result.data!.isEmpty)
                                  ? Center(
                                      child: Text(
                                        "Kursus tidak ditemukan",
                                        style: redTextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: regular,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: dataLength,
                                      itemBuilder: (context, index) {
                                        var result = state.result.data![index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const JoinCourseScreen(),
                                                settings: RouteSettings(arguments: refreshData()),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(bottom: 24),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    image: DecorationImage(
                                                      image: NetworkImage(defaultImage),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      result.title!,
                                                      style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                                                    ),
                                                    const SizedBox(height: 12),
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          width: 150,
                                                          child: Text(
                                                            result.description!,
                                                            style: greyTextStyle.copyWith(fontSize: 12, fontWeight: regular),
                                                            overflow: TextOverflow.ellipsis,
                                                            softWrap: false,
                                                            maxLines: 3,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            } else {
                              return const SizedBox();
                            }
                          },
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

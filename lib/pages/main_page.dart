import 'dart:io';
import 'dart:ui';

//Packages
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:movie_haven/pages/videoPlayer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// Models
import '../models/movie.dart';
import '../models/search_category.dart';
import '../models/main_page_data.dart';

//Pages

// Controllers
import '../controllers/main_page_data_controller.dart';

// Widgets
import '../widgets/movie_tile.dart';

final mainPageDataControllerProvider =
    StateNotifierProvider<MainPageDataController, MainPageData>((ref) {
  return MainPageDataController();
});

final selectedMoviePosterUrlProvider = StateProvider<String?>((ref) {
  final _movies = ref.watch(mainPageDataControllerProvider).movies!;
  return _movies.length != 0 ? _movies[0].posterURL() : null;
});

final selectedMovieNameProvider = StateProvider<String?>((ref) {
  final _movies = ref.watch(mainPageDataControllerProvider).movies!;
  return _movies.length != 0 ? _movies[0].name : null;
});

class MainPage extends ConsumerWidget {
  double? _deviceHeight;
  double? _deviceWidth;

  late var _selectedMoviePosterURL;
  late var _selectedMovieName;

  late MainPageDataController _mainPageDataController;
  late MainPageData _mainPageData;

  late VideoPlayer _videoPlayer;

  TextEditingController? _searchTextFieldController;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    _mainPageDataController = watch(mainPageDataControllerProvider.notifier);
    _mainPageData = watch(mainPageDataControllerProvider);

    _selectedMoviePosterURL = watch(selectedMoviePosterUrlProvider);
    _selectedMovieName = watch(selectedMovieNameProvider);

    _videoPlayer = VideoPlayer();

    _searchTextFieldController = TextEditingController();
    _searchTextFieldController!.text = _mainPageData.searchText!;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backgroundWidget(),
            _foregroundWidgets(),
          ],
        ),
      ),
    );
  }

  Widget _backgroundWidget() {
    if (_selectedMoviePosterURL.state != null) {
      return Container(
        height: _deviceHeight,
        width: _deviceWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(_selectedMoviePosterURL.state),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
              ),
            )),
      );
    } else {
      return Container(
        height: _deviceHeight,
        width: _deviceWidth,
        color: Colors.black,
      );
    }
  }

  Widget _foregroundWidgets() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, _deviceHeight! * 0.02, 0, 0),
      width: _deviceWidth! * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _topBarWidget(),
          Container(
            height: _deviceHeight! * 0.83,
            padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.01),
            child: _moviesListViewWidget(),
          ),
        ],
      ),
    );
  }

  Widget _topBarWidget() {
    return Container(
      height: _deviceHeight! * 0.08,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _searchFieldWidget(),
          _categorySelectionWidget(),
        ],
      ),
    );
  }

  Widget _searchFieldWidget() {
    final _border = InputBorder.none;
    return Container(
      width: _deviceWidth! * 0.50,
      height: _deviceHeight! * 0.05,
      child: TextField(
        controller: _searchTextFieldController,
        onSubmitted: (_input) =>
            _mainPageDataController.updateSearchText(_input),
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            focusedBorder: _border,
            border: _border,
            prefixIcon: Icon(Icons.search, color: Colors.white24),
            hintStyle: TextStyle(color: Colors.white54),
            filled: false,
            fillColor: Colors.white24,
            hintText: 'Search....'),
      ),
    );
  }

  Widget _categorySelectionWidget() {
    return DropdownButton(
      dropdownColor: Colors.black38,
      value: _mainPageData.searchCategory,
      icon: Icon(
        Icons.menu,
        color: Colors.white24,
      ),
      underline: Container(
        height: 1,
        color: Colors.white24,
      ),
      onChanged: (dynamic _value) => _value.toString().isNotEmpty
          ? _mainPageDataController.updateSearchCategory(_value)
          : null,
      items: [
        DropdownMenuItem(
          child: Text(
            SearchCategory.popular,
            style: TextStyle(color: Colors.white),
          ),
          value: SearchCategory.popular,
        ),
        DropdownMenuItem(
          child: Text(
            SearchCategory.upcoming,
            style: TextStyle(color: Colors.white),
          ),
          value: SearchCategory.upcoming,
        ),
        DropdownMenuItem(
          child: Text(
            SearchCategory.none,
            style: TextStyle(color: Colors.white),
          ),
          value: SearchCategory.none,
        ),
      ],
    );
  }

  void _playVideo(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(_selectedMovieName.state!),
            content: _videoPlayer,
          );
        });
  }

  Widget _moviesListViewWidget() {
    final List<Movie> _movies = _mainPageData.movies!;

    if (_movies.length != 0) {
      return NotificationListener(
        onNotification: (_onScrollNotification) {
          if (_onScrollNotification is ScrollEndNotification) {
            final before = _onScrollNotification.metrics.extentBefore;
            final max = _onScrollNotification.metrics.maxScrollExtent;
            if (before == max) {
              _mainPageDataController.getMovies();
              return true;
            }
            return false;
          }
          return false;
        },
        child: ListView.builder(
          // scrollDirection: Axis.horizontal,
          itemCount: _movies.length,
          itemBuilder: (BuildContext _context, int _count) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: _deviceHeight! * 0.01, horizontal: 0),
              child: GestureDetector(
                onTap: () {
                  _selectedMoviePosterURL.state = _movies[_count].posterURL();
                },
                onDoubleTap: () {
                  _selectedMovieName.state = _movies[_count].name;
                  _mainPageDataController.getTrailers();
                  _playVideo(_context);
                },
                child: MovieTile(
                  movie: _movies[_count],
                  height: _deviceHeight! * 0.20,
                  width: _deviceWidth! * 0.85,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    }
  }
}

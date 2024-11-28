import 'package:flutter/material.dart';
import 'package:moviesapps/model/tv_model.dart';
import 'package:moviesapps/service/api_service.dart';
import 'package:moviesapps/ui/movie/tv/componants/tv_list_item.dart';

class TvCategory extends StatefulWidget {

final TvType tvType;
final int tvid;
  const TvCategory({super.key,required this.tvType,this.tvid=0});

  @override
  State<TvCategory> createState() => _TvCategoryState();
}

class _TvCategoryState extends State<TvCategory> {
  ApiService apiService=ApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder( builder:(context,snapshot){
    
    if(snapshot.hasData)
    {
     List<TvModel>tvlist=snapshot.data ?? [];

     return ListView.builder(itemBuilder: (context,index){

     return TvListItem(tvModel: tvlist[index],);
      
     }, itemCount: tvlist.length,
     scrollDirection: Axis.horizontal,
     
     );
    }
    return Center(child: CircularProgressIndicator(),);

    },
    future: apiService.getTvData(widget.tvType,tvId: widget.tvid),
    );
  }
}
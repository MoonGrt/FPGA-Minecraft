module video_driver
#(  // 默认 800*600 分辨率时序参数
    parameter  H_SYNC   =  12'd128,     //行同步
    parameter  H_BACK   =  12'd88,      //行显示后沿
    parameter  H_DISP   =  12'd800,     //行有效数据
    parameter  H_TOTAL  =  12'd1056,    //行扫描周期
    
    parameter  V_SYNC   =  12'd3,       //场同步
    parameter  V_BACK   =  12'd21,      //场显示后沿
    parameter  V_DISP   =  12'd480,     //场有效数据
    parameter  V_TOTAL  =  12'd505      //场扫描周期)
)(
    input           	pixel_clk	,
    input           	sys_rst_n	,
		
    //RGB接口	
    output          	video_hs	,    //行同步信号
    output          	video_vs	,    //场同步信号
    output          	video_de	,    //数据使能
    output  	[23:0]  video_rgb	,    //RGB888颜色数据
    output	reg			data_req 	,
	
    input   	[23:0]  pixel_data	,   //像素点数据
    output  reg	[11:0]  pixel_xpos	,   //像素点横坐标
    output  reg	[11:0]  pixel_ypos      //像素点纵坐标
);
    
//reg define
reg  [12:0] cnt_h;
reg  [12:0] cnt_v;
reg       	video_en;

//*****************************************************
//**                    main code
//*****************************************************

assign video_de  = video_en;
assign video_hs  = (cnt_h < H_SYNC) ? 1'b0 : 1'b1;  //行同步信号赋值
assign video_vs  = (cnt_v < V_SYNC) ? 1'b0 : 1'b1;  //场同步信号赋值
assign video_rgb = video_de ? pixel_data : 24'd0;

//使能RGB数据输出
always @(posedge pixel_clk or negedge sys_rst_n) begin
	if(!sys_rst_n)
		video_en <= 1'b0;
	else
		video_en <= data_req;
end

//请求像素点颜色数据输入
always @(posedge pixel_clk or negedge sys_rst_n) begin
	if(!sys_rst_n)
		data_req <= 1'b0;
	else if(((cnt_h >= H_SYNC + H_BACK - 2'd2) && (cnt_h < H_SYNC + H_BACK + H_DISP - 2'd2))
                  && ((cnt_v >= V_SYNC + V_BACK) && (cnt_v < V_SYNC + V_BACK+V_DISP)))
		data_req <= 1'b1;
	else
		data_req <= 1'b0;
end

//像素点x坐标
always@ (posedge pixel_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        pixel_xpos <= 11'd0;
    else if(data_req)
        pixel_xpos <= cnt_h + 2'd2 - H_SYNC - H_BACK ;
    else 
        pixel_xpos <= 11'd0;
end
    
//像素点y坐标	
always@ (posedge pixel_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        pixel_ypos <= 11'd0;
    else if((cnt_v >= (V_SYNC + V_BACK)) && (cnt_v < (V_SYNC + V_BACK + V_DISP)))
//        pixel_ypos <= cnt_v + 1'b1 - (V_SYNC + V_BACK) ;
        pixel_ypos <= cnt_v - (V_SYNC + V_BACK) ;
    else 
        pixel_ypos <= 11'd0;
end

//行计数器对像素时钟计数
always @(posedge pixel_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        cnt_h <= 11'd0;
    else begin
        if(cnt_h < H_TOTAL - 1'b1)
            cnt_h <= cnt_h + 1'b1;
        else 
            cnt_h <= 11'd0;
    end
end

//场计数器对行计数
always @(posedge pixel_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        cnt_v <= 11'd0;
    else if(cnt_h == H_TOTAL - 1'b1) begin
        if(cnt_v < V_TOTAL - 1'b1)
            cnt_v <= cnt_v + 1'b1;
        else 
            cnt_v <= 11'd0;
    end
end

endmodule
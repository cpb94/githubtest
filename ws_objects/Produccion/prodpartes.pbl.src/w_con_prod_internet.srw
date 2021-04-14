$PBExportHeader$w_con_prod_internet.srw
$PBExportComments$Informe de producción por internet
forward
global type w_con_prod_internet from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_prod_internet
end type
type em_fechadesde from u_em_campo within w_con_prod_internet
end type
type st_7 from statictext within w_con_prod_internet
end type
type cb_2 from commandbutton within w_con_prod_internet
end type
type em_fechahasta from u_em_campo within w_con_prod_internet
end type
type st_1 from statictext within w_con_prod_internet
end type
type dw_detalle from datawindow within w_con_prod_internet
end type
type dw_detalle2 from datawindow within w_con_prod_internet
end type
type dw_detalle3 from datawindow within w_con_prod_internet
end type
type dw_detalle4 from datawindow within w_con_prod_internet
end type
type gb_4 from groupbox within w_con_prod_internet
end type
type gb_3 from groupbox within w_con_prod_internet
end type
type gb_2 from groupbox within w_con_prod_internet
end type
type gb_1 from groupbox within w_con_prod_internet
end type
type pb_1 from picturebutton within w_con_prod_internet
end type
type pb_4 from picturebutton within w_con_prod_internet
end type
type dw_1 from datawindow within w_con_prod_internet
end type
type dw_detalle5 from datawindow within w_con_prod_internet
end type
type dw_detalle6 from datawindow within w_con_prod_internet
end type
type dw_detalle7 from datawindow within w_con_prod_internet
end type
type dw_detalle8 from datawindow within w_con_prod_internet
end type
type dw_detalle9 from datawindow within w_con_prod_internet
end type
type sle_direccion from singlelineedit within w_con_prod_internet
end type
type st_2 from statictext within w_con_prod_internet
end type
type gb_5 from groupbox within w_con_prod_internet
end type
type gb_6 from groupbox within w_con_prod_internet
end type
type gb_7 from groupbox within w_con_prod_internet
end type
type gb_8 from groupbox within w_con_prod_internet
end type
type gb_9 from groupbox within w_con_prod_internet
end type
end forward

global type w_con_prod_internet from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 4471
integer height = 2088
string title = "Consulta de Movimientos"
pb_2 pb_2
em_fechadesde em_fechadesde
st_7 st_7
cb_2 cb_2
em_fechahasta em_fechahasta
st_1 st_1
dw_detalle dw_detalle
dw_detalle2 dw_detalle2
dw_detalle3 dw_detalle3
dw_detalle4 dw_detalle4
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
pb_1 pb_1
pb_4 pb_4
dw_1 dw_1
dw_detalle5 dw_detalle5
dw_detalle6 dw_detalle6
dw_detalle7 dw_detalle7
dw_detalle8 dw_detalle8
dw_detalle9 dw_detalle9
sle_direccion sle_direccion
st_2 st_2
gb_5 gb_5
gb_6 gb_6
gb_7 gb_7
gb_8 gb_8
gb_9 gb_9
end type
global w_con_prod_internet w_con_prod_internet

type variables
String	destino,asunto

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);String    articulo,formato,descripcion_articulo,descripcion_formato,var_codigo
Long      indice,total,donde
Datetime  fecha1,fecha2
Datastore datos

data.Reset()
dw_detalle2.reset()
dw_detalle3.reset()
dw_detalle4.reset()

data.setredraw(false)
dw_detalle2.setredraw(false)
dw_detalle3.setredraw(false)
dw_detalle4.setredraw(false)

fecha1 = Datetime(Date(em_fechadesde.Text))
fecha2 = Datetime(Date(em_fechahasta.Text))

data.Retrieve(fecha1,fecha2)

total = data.rowcount()
if total = 0 then
	messagebox("Atención","No hay datos")
	return
else
	dw_detalle2.Retrieve(fecha1,fecha2)
	dw_detalle3.Retrieve(fecha1,fecha2)
	dw_detalle4.Retrieve(fecha1,fecha2)
	dw_detalle5.Retrieve(fecha1,fecha2)
	dw_detalle6.Retrieve(fecha1,fecha2)
	dw_detalle7.Retrieve()
	dw_detalle8.Retrieve()
	dw_detalle9.Retrieve()
end if

//for indice = 1 to total
//	f_mensaje_proceso("Calculando datos",indice,total)
//	articulo    = data.object.articulo[indice]
//	
//	select articulos.codigo
//	into :var_codigo
//	from articulos
//	where codigo = :articulo;
//	
//	if sqlca.sqlcode = 0 then
//		formato     = f_formato_articulo(codigo_empresa,articulo)
//		
//		if trim(formato) = "" or isnull(formato) then
//			messagebox("Atención. Formato Nulo",articulo + " " + f_nombre_articulo(codigo_empresa,articulo))
//		end if
//			
//		donde   = dw_detalle2.find("codigo = '"+articulo+"'",1,dw_detalle2.rowcount())
//		if donde = 0 then
//			donde = dw_detalle2.insertrow(0)
//			dw_detalle2.object.empresa[donde]     = codigo_empresa
//			dw_detalle2.object.codigo[donde]      = articulo
//			dw_detalle2.object.descripcion[donde] = f_nombre_articulo(codigo_empresa,articulo)
//			dw_detalle2.object.formato[donde]     = formato
//		end if
//		
//		donde   = dw_detalle3.find("codigo = '"+formato+"'",1,dw_detalle3.rowcount())
//		if donde = 0 then
//			donde = dw_detalle3.insertrow(0)
//			dw_detalle3.object.empresa[donde]     = codigo_empresa
//			dw_detalle3.object.codigo[donde]      = formato
//			dw_detalle3.object.descripcion[donde] = f_nombre_formato(codigo_empresa,formato)
//			dw_detalle3.object.largo[donde]       = f_nombre_formato_parte2(codigo_empresa,formato)
//			dw_detalle3.object.ancho[donde]       = f_nombre_formato_parte1(codigo_empresa,formato)
//		end if
//	end if
//next

//dw_detalle4.Retrieve()

data.sort()
data.groupcalc()
data.setredraw(true)

dw_detalle2.sort()
dw_detalle2.groupcalc()
dw_detalle2.setredraw(true)

dw_detalle3.sort()
dw_detalle3.groupcalc()
dw_detalle3.setredraw(true)

dw_detalle4.sort()
dw_detalle4.groupcalc()
dw_detalle4.setredraw(true)
end subroutine

event open;call super::open;This.title = " CONSULTA PRODUCCIÓN INTERNET "
dw_detalle.SetTransObject(sqlca)
dw_detalle2.SetTransObject(sqlca)
dw_detalle3.SetTransObject(sqlca)
dw_detalle4.SetTransObject(sqlca)
dw_detalle5.SetTransObject(sqlca)
dw_detalle6.SetTransObject(sqlca)
dw_detalle7.SetTransObject(sqlca)
dw_detalle8.SetTransObject(sqlca)
dw_detalle9.SetTransObject(sqlca)

dw_1.SetTransObject(sqlca)
em_fechadesde.text=String(DateTime(Today()),"dd-mm-yy")
em_fechahasta.text=String(DateTime(Today()),"dd-mm-yy")
f_activar_campo(em_fechadesde)
end event

on w_con_prod_internet.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.st_7=create st_7
this.cb_2=create cb_2
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.dw_detalle=create dw_detalle
this.dw_detalle2=create dw_detalle2
this.dw_detalle3=create dw_detalle3
this.dw_detalle4=create dw_detalle4
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.pb_1=create pb_1
this.pb_4=create pb_4
this.dw_1=create dw_1
this.dw_detalle5=create dw_detalle5
this.dw_detalle6=create dw_detalle6
this.dw_detalle7=create dw_detalle7
this.dw_detalle8=create dw_detalle8
this.dw_detalle9=create dw_detalle9
this.sle_direccion=create sle_direccion
this.st_2=create st_2
this.gb_5=create gb_5
this.gb_6=create gb_6
this.gb_7=create gb_7
this.gb_8=create gb_8
this.gb_9=create gb_9
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.st_7
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_detalle
this.Control[iCurrent+8]=this.dw_detalle2
this.Control[iCurrent+9]=this.dw_detalle3
this.Control[iCurrent+10]=this.dw_detalle4
this.Control[iCurrent+11]=this.gb_4
this.Control[iCurrent+12]=this.gb_3
this.Control[iCurrent+13]=this.gb_2
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.pb_1
this.Control[iCurrent+16]=this.pb_4
this.Control[iCurrent+17]=this.dw_1
this.Control[iCurrent+18]=this.dw_detalle5
this.Control[iCurrent+19]=this.dw_detalle6
this.Control[iCurrent+20]=this.dw_detalle7
this.Control[iCurrent+21]=this.dw_detalle8
this.Control[iCurrent+22]=this.dw_detalle9
this.Control[iCurrent+23]=this.sle_direccion
this.Control[iCurrent+24]=this.st_2
this.Control[iCurrent+25]=this.gb_5
this.Control[iCurrent+26]=this.gb_6
this.Control[iCurrent+27]=this.gb_7
this.Control[iCurrent+28]=this.gb_8
this.Control[iCurrent+29]=this.gb_9
end on

on w_con_prod_internet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.st_7)
destroy(this.cb_2)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.dw_detalle)
destroy(this.dw_detalle2)
destroy(this.dw_detalle3)
destroy(this.dw_detalle4)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.pb_1)
destroy(this.pb_4)
destroy(this.dw_1)
destroy(this.dw_detalle5)
destroy(this.dw_detalle6)
destroy(this.dw_detalle7)
destroy(this.dw_detalle8)
destroy(this.dw_detalle9)
destroy(this.sle_direccion)
destroy(this.st_2)
destroy(this.gb_5)
destroy(this.gb_6)
destroy(this.gb_7)
destroy(this.gb_8)
destroy(this.gb_9)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_prod_internet
integer x = 1202
integer y = 24
integer taborder = 70
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_prod_internet
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_prod_internet
integer y = 12
integer width = 4215
integer height = 88
integer textsize = -12
end type

type pb_2 from upb_salir within w_con_prod_internet
integer x = 4288
integer y = 12
integer width = 114
integer height = 92
integer taborder = 0
end type

type em_fechadesde from u_em_campo within w_con_prod_internet
integer x = 562
integer y = 136
integer width = 311
integer height = 80
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_7 from statictext within w_con_prod_internet
integer x = 37
integer y = 136
integer width = 494
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "Fechas :"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_con_prod_internet
event clicked pbm_bnclicked
integer x = 3529
integer y = 124
integer width = 795
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\mano.cur"
string text = "Consulta"
end type

event clicked;f_control(dw_detalle)
end event

type em_fechahasta from u_em_campo within w_con_prod_internet
integer x = 946
integer y = 136
integer width = 311
integer height = 80
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_1 from statictext within w_con_prod_internet
integer x = 896
integer y = 140
integer width = 46
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "-"
boolean focusrectangle = false
end type

type dw_detalle from datawindow within w_con_prod_internet
integer x = 50
integer y = 284
integer width = 3433
integer height = 280
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_con_prod_internet"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_detalle2 from datawindow within w_con_prod_internet
integer x = 50
integer y = 652
integer width = 2121
integer height = 216
integer taborder = 90
boolean bringtotop = true
string dataobject = "dw_con_prod_internet_articulos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_detalle3 from datawindow within w_con_prod_internet
integer x = 2249
integer y = 644
integer width = 2121
integer height = 216
integer taborder = 130
boolean bringtotop = true
string dataobject = "dw_con_prod_internet_versiones"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_detalle4 from datawindow within w_con_prod_internet
integer x = 50
integer y = 960
integer width = 2121
integer height = 216
integer taborder = 140
boolean bringtotop = true
string dataobject = "dw_con_prod_internet_formatos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_4 from groupbox within w_con_prod_internet
integer x = 32
integer y = 900
integer width = 2162
integer height = 312
integer taborder = 110
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "formatos"
end type

type gb_3 from groupbox within w_con_prod_internet
integer x = 2231
integer y = 588
integer width = 2162
integer height = 312
integer taborder = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "art_versiones"
end type

type gb_2 from groupbox within w_con_prod_internet
integer x = 32
integer y = 588
integer width = 2162
integer height = 312
integer taborder = 120
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "articulos"
end type

type gb_1 from groupbox within w_con_prod_internet
integer x = 32
integer y = 220
integer width = 3502
integer height = 364
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "prodpartes_ot"
end type

type pb_1 from picturebutton within w_con_prod_internet
integer x = 3611
integer y = 260
integer width = 325
integer height = 292
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\mano.cur"
string picturename = "C:\Bmp\rana1.gif"
end type

event clicked;String  ejecuta, fichero1, fichero2, fichero3, fichero4, fichero5, fichero6, fichero7, fichero8, fichero9
Integer resultado,bien,dia1,dia2,mes1,mes2,anyo1,anyo2
Long    donde

bien = 0
fichero1 = "c:\temp\prodpartes_ot.txt"
resultado = dw_detalle.saveas(fichero1,text!,false)
if resultado = -1 then 
	f_mensaje("ERROR","Al grabar el fichero "+fichero1)	
	bien = 1
end if

fichero2 = "c:\temp\articulos.txt"
resultado = dw_detalle2.saveas(fichero2,text!,false)
if resultado = -1 then 
	f_mensaje("ERROR","Al grabar el fichero "+fichero2)
	bien = 1
end if

fichero3 = "c:\temp\art_versiones.txt"
resultado = dw_detalle3.saveas(fichero3,text!,false)
if resultado = -1 then 
	f_mensaje("ERROR","Al grabar el fichero "+fichero3)
	bien = 1
end if

fichero4 = "c:\temp\formatos.txt"
resultado = dw_detalle4.saveas(fichero4,text!,false)
if resultado = -1 then 
	f_mensaje("ERROR","Al grabar el fichero "+fichero4)
	bien = 1
end if

fichero5 = "c:\temp\art_codestadistico.txt"
resultado = dw_detalle5.saveas(fichero5,text!,false)
if resultado = -1 then 
	f_mensaje("ERROR","Al grabar el fichero "+fichero5)
	bien = 1
end if

fichero6 = "c:\temp\art_ver_operaciones.txt"
resultado = dw_detalle6.saveas(fichero6,text!,false)
if resultado = -1 then 
	f_mensaje("ERROR","Al grabar el fichero "+fichero6)
	bien = 1
end if

fichero7 = "c:\temp\art_ver_tipooperacion.txt"
resultado = dw_detalle7.saveas(fichero7,text!,false)
if resultado = -1 then 
	f_mensaje("ERROR","Al grabar el fichero "+fichero7)
	bien = 1
end if

fichero8 = "c:\temp\prodlineas.txt"
resultado = dw_detalle8.saveas(fichero8,text!,false)
if resultado = -1 then 
	f_mensaje("ERROR","Al grabar el fichero "+fichero8)
	bien = 1
end if

fichero9 = "c:\temp\prodsecciones.txt"
resultado = dw_detalle9.saveas(fichero9,text!,false)
if resultado = -1 then 
	f_mensaje("ERROR","Al grabar el fichero "+fichero9)
	bien = 1
end if




dia1  = day(date(em_fechadesde.text))
mes1  = month(date(em_fechadesde.text))
anyo1 = year(date(em_fechadesde.text))

dia2  = day(date(em_fechahasta.text))
mes2  = month(date(em_fechahasta.text))
anyo2 = year(date(em_fechahasta.text))

if em_fechadesde.text <> em_fechahasta.text then
	destino = "C:\TEMP\PARTES_TENCER_"+right("00"+string(dia1,"##"),2)+right("00"+string(mes1,"##"),2)+right(string(anyo1,"####"),2)+"_"+right("00"+string(dia2,"##"),2)+right("00"+string(mes2,"##"),2)+right(string(anyo2,"####"),2)+".zip"
	asunto  = "INFORME_"+right("00"+string(dia1,"##"),2)+right("00"+string(mes1,"##"),2)+right(string(anyo1,"####"),2)+"_"+right("00"+string(dia2,"##"),2)+right("00"+string(mes2,"##"),2)+right(string(anyo2,"####"),2)+".zip"
else
	destino = "C:\TEMP\PARTES_TENCER_"+right("00"+string(dia1,"##"),2)+right("00"+string(mes1,"##"),2)+right(string(anyo1,"####"),2)+".zip"
	asunto  = "INFORME_"+right("00"+string(dia1,"##"),2)+right("00"+string(mes1,"##"),2)+right(string(anyo1,"####"),2)+".zip"
end if

//Compresión con WinZip
//ejecuta = "C:\Archivos de programa\WinZip\winzip32 -min -a -en "+destino+" "+fichero1+" "+fichero2+" "+fichero3+" "+fichero4

if fileexists("C:\TEMP\enviar_informe.aks") then
	filedelete("C:\TEMP\enviar_informe.aks")
end if

//Compresión con QuikZip 
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "OPEN "+'"'+trim(destino)+'"'
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "ADD "+'"C:\TEMP\prodpartes_ot.txt"'
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "DOADD"
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "ADD "+'"C:\TEMP\articulos.txt"'
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "DOADD"
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "ADD "+'"C:\TEMP\formatos.txt"'
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "DOADD"
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "ADD "+'"C:\TEMP\art_codestadistico.txt"'
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "DOADD"
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "ADD "+'"C:\TEMP\art_ver_operaciones.txt"'
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "DOADD"
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "ADD "+'"C:\TEMP\art_ver_tipooperacion.txt"'
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "DOADD"
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "ADD "+'"C:\TEMP\art_versiones.txt"'
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "DOADD"
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "ADD "+'"C:\TEMP\prodlineas.txt"'
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "DOADD"
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "ADD "+'"C:\TEMP\prodsecciones.txt"'
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "DOADD"
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "CLOSE"
donde = dw_1.insertrow(0)
dw_1.object.cadena[donde] = "CLOSEARC"

dw_1.saveas("C:\TEMP\enviar_informe.aks",text!,false)

//Versión de QuickZip 3.01
ejecuta = "C:\Archivos de programa\QuickZip\QuickZip C:\TEMP\enviar_informe.aks"

resultado = run(ejecuta,Minimized!)

if resultado = -1 then 
	f_mensaje("ERROR","Al comprimir el fichero "+destino)
	bien = 1
end if
if bien = 1 then
	messagebox("Atención","Proceso terminado con errores")
	return
end if






end event

type pb_4 from picturebutton within w_con_prod_internet
integer x = 4014
integer y = 256
integer width = 325
integer height = 292
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\mano.cur"
string picturename = "C:\Bmp\bull_dog_gaurding_letter_md_wht2.gif"
end type

event clicked;Integer dia1,dia2,mes1,mes2,anyo1,anyo2


dia1  = day(date(em_fechadesde.text))
mes1  = month(date(em_fechadesde.text))
anyo1 = year(date(em_fechadesde.text))

dia2  = day(date(em_fechahasta.text))
mes2  = month(date(em_fechahasta.text))
anyo2 = year(date(em_fechahasta.text))

if em_fechadesde.text <> em_fechahasta.text then
	destino = "C:\TEMP\PARTES_TENCER_"+right("00"+string(dia1,"##"),2)+right("00"+string(mes1,"##"),2)+right(string(anyo1,"####"),2)+"_"+right("00"+string(dia2,"##"),2)+right("00"+string(mes2,"##"),2)+right(string(anyo2,"####"),2)+".zip"
	asunto  = "PARTES_TENCER_"+right("00"+string(dia1,"##"),2)+right("00"+string(mes1,"##"),2)+right(string(anyo1,"####"),2)+"_"+right("00"+string(dia2,"##"),2)+right("00"+string(mes2,"##"),2)+right(string(anyo2,"####"),2)+".zip"
else
	destino = "C:\TEMP\PARTES_TENCER_"+right("00"+string(dia1,"##"),2)+right("00"+string(mes1,"##"),2)+right(string(anyo1,"####"),2)+".zip"
	asunto  = "PARTES_TENCER_"+right("00"+string(dia1,"##"),2)+right("00"+string(mes1,"##"),2)+right(string(anyo1,"####"),2)+".zip"
end if


/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 	ENVIO POR CORREO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

if sle_direccion.text <> '' then

	mailsession ms 
	mailrecipient mr 
	mailmessage mm 
	mailfiledescription md 
	ms = create mailsession 
	
	if ms.maillogon() <> mailreturnsuccess! then 
	messagebox('E-MAIL STARTUP ERROR!', 'Error on MailLogon') 
	return 
	end if 
	
	//mr.name = 'dmartinezmart@terra.es' 
	mr.address = sle_direccion.text
	mr.recipienttype = mailto! 
	
	md.filetype = mailattach! 
	md.pathname = destino
	md.filename = destino
	md.position = -1 
	
	mm.notetext = asunto 
	mm.subject = 'Partes Tencer' 
	mm.recipient[1] = mr 
	mm.attachmentfile[1] = md 
	
	if ms.mailsend(mm) <> mailreturnsuccess! then 
	messagebox('E-MAIL SEND ERROR!', 'Error in MailSend') 
	return 
	end if 
	
	ms.maillogoff() 
	destroy ms 
else
	messagebox("Aviso", "Introduzca una dirección de correo")
end if


/*
OLEObject ole_outlook,ole_item,ole_attach
Long      resultado
Uint      val


Envío a través de Outlook
if messagebox("Atención","¿Desea enviar el informe?",Exclamation!,YesNO!) = 1 then
	

	
	val  = FindWindowA(0,"Bandeja de entrada - Microsoft Outlook")
	if val = 0 then
		messagebox("Atención","No puedo conectar con OutLook")
		return
	else
		if fileexists(trim(destino)) then
			ole_outlook = create OLEObject
			resultado = ole_outlook.ConnectToNewObject("Outlook.application")
			if resultado <> 0 then
				messagebox("Atención","No puedo conectar con OutLook")
				destroy ole_outlook
				return
			end if
			ole_item = ole_outlook.CreateItem(0)
			ole_item.display()
			ole_item.subject = asunto
			ole_item.to = "informatica@keramia.es"
			ole_attach  = ole_item.Attachments
			ole_attach.add(destino)
			ole_item.send
			destroy ole_item
			destroy ole_outlook
		else
			messagebox("Atención","El informe "+trim(destino)+" todavía no se ha generado")
		end if
	end if
end if
*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/



end event

type dw_1 from datawindow within w_con_prod_internet
boolean visible = false
integer x = 3625
integer y = 1652
integer width = 251
integer height = 108
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_quickzip"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_detalle5 from datawindow within w_con_prod_internet
integer x = 2249
integer y = 960
integer width = 2121
integer height = 216
integer taborder = 150
boolean bringtotop = true
string dataobject = "dw_con_prod_internet_art_codestadistico"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_detalle6 from datawindow within w_con_prod_internet
integer x = 50
integer y = 1272
integer width = 2121
integer height = 216
integer taborder = 160
boolean bringtotop = true
string dataobject = "dw_con_prod_internet_art_ver_operaciones"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_detalle7 from datawindow within w_con_prod_internet
integer x = 2249
integer y = 1272
integer width = 2121
integer height = 216
integer taborder = 170
boolean bringtotop = true
string dataobject = "dw_con_prod_internet_tipooperacion"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_detalle8 from datawindow within w_con_prod_internet
integer x = 46
integer y = 1584
integer width = 2121
integer height = 216
integer taborder = 170
boolean bringtotop = true
string dataobject = "dw_con_prod_internet_prodlineas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_detalle9 from datawindow within w_con_prod_internet
integer x = 2249
integer y = 1588
integer width = 2121
integer height = 216
integer taborder = 170
boolean bringtotop = true
string dataobject = "dw_con_prod_internet_prodsecciones"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_direccion from singlelineedit within w_con_prod_internet
integer x = 1682
integer y = 128
integer width = 1815
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "informes@keramia.es"
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_con_prod_internet
integer x = 1413
integer y = 132
integer width = 261
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 80269524
boolean enabled = false
string text = "e-mail:"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_5 from groupbox within w_con_prod_internet
integer x = 2231
integer y = 900
integer width = 2162
integer height = 312
integer taborder = 120
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "art_codestadistico"
end type

type gb_6 from groupbox within w_con_prod_internet
integer x = 32
integer y = 1212
integer width = 2162
integer height = 312
integer taborder = 130
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "art_ver_operaciones"
end type

type gb_7 from groupbox within w_con_prod_internet
integer x = 2231
integer y = 1524
integer width = 2162
integer height = 312
integer taborder = 140
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "prodsecciones"
end type

type gb_8 from groupbox within w_con_prod_internet
integer x = 32
integer y = 1524
integer width = 2162
integer height = 312
integer taborder = 140
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "prodlineas"
end type

type gb_9 from groupbox within w_con_prod_internet
integer x = 2231
integer y = 1212
integer width = 2162
integer height = 312
integer taborder = 140
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "art_ver_tipooperacion"
end type


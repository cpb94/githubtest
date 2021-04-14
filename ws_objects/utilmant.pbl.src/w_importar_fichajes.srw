$PBExportHeader$w_importar_fichajes.srw
forward
global type w_importar_fichajes from w_int_con_empresa
end type
type r_1 from rectangle within w_importar_fichajes
end type
type pb_2 from upb_salir within w_importar_fichajes
end type
type cb_1 from u_boton within w_importar_fichajes
end type
type st_1 from statictext within w_importar_fichajes
end type
type st_2 from statictext within w_importar_fichajes
end type
type st_3 from statictext within w_importar_fichajes
end type
type st_4 from statictext within w_importar_fichajes
end type
type st_5 from statictext within w_importar_fichajes
end type
type st_6 from statictext within w_importar_fichajes
end type
type st_reloj from statictext within w_importar_fichajes
end type
type st_fecha from statictext within w_importar_fichajes
end type
type st_funcion from statictext within w_importar_fichajes
end type
type st_incidencia from statictext within w_importar_fichajes
end type
end forward

global type w_importar_fichajes from w_int_con_empresa
integer x = 5
integer y = 792
integer width = 1833
integer height = 1084
string title = "Consulta de Movimientos"
r_1 r_1
pb_2 pb_2
cb_1 cb_1
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_reloj st_reloj
st_fecha st_fecha
st_funcion st_funcion
st_incidencia st_incidencia
end type
global w_importar_fichajes w_importar_fichajes

type variables
String	is_codigo,ante_articulo
String  devolver,var_envio
end variables

event open;call super::open;This.title = "PROCESO IMPORTAR FIHCAJES"
istr_parametros = Message.PowerObjectParm

 
end event

on w_importar_fichajes.create
int iCurrent
call super::create
this.r_1=create r_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_reloj=create st_reloj
this.st_fecha=create st_fecha
this.st_funcion=create st_funcion
this.st_incidencia=create st_incidencia
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.r_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.st_6
this.Control[iCurrent+10]=this.st_reloj
this.Control[iCurrent+11]=this.st_fecha
this.Control[iCurrent+12]=this.st_funcion
this.Control[iCurrent+13]=this.st_incidencia
end on

on w_importar_fichajes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.r_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_reloj)
destroy(this.st_fecha)
destroy(this.st_funcion)
destroy(this.st_incidencia)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_importar_fichajes
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_importar_fichajes
end type

type st_empresa from w_int_con_empresa`st_empresa within w_importar_fichajes
integer y = 20
integer width = 1641
end type

type r_1 from rectangle within w_importar_fichajes
integer linethickness = 4
long fillcolor = 16777215
integer x = 411
integer y = 476
integer width = 869
integer height = 344
end type

type pb_2 from upb_salir within w_importar_fichajes
integer x = 1568
integer y = 192
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type cb_1 from u_boton within w_importar_fichajes
integer x = 160
integer y = 196
integer width = 1371
integer height = 204
integer taborder = 10
integer textsize = -18
fontcharset fontcharset = ansi!
string text = "Importar Fichajes"
end type

event clicked;long fichero, final, i, fichero_Error
string datos, reloj, funcion, incidencia, tarjeta
string forigen, fdestino, ferror
datetime fecha
boolean hay_errores = false


forigen = "C:\ROBOT52\MARCAWIN"
fdestino =  "C:\ROBOT52\LECTURAS\LECTURA "+STRING(TODAY(),'DD-MM-YY')
ferror = "C:\ROBOT52\LECTURAS\FICHERROR "+STRING(TODAY(),'DD-MM-YY')


i = 1
ferror = ferror+"#"
do while FileExists(ferror+string(i))
	i++
loop

ferror = ferror+string(i)

fichero = FileOpen(forigen, linemode!)

do
   final = fileread(fichero, datos)  
	if	len(datos) = 76 then
		reloj 			= Mid ( datos, 2 , 2 )
		fecha 			= datetime(	date(Mid ( datos, 4 , 2 )+"-"+Mid ( datos, 6 , 2 )+"-"+Mid ( datos, 8 , 2 )), &
											time(Mid ( datos, 24 , 2 )+":"+Mid ( datos, 27 , 2 )) )
		funcion 			= Mid ( datos, 10 , 3 )
		incidencia 		= Mid ( datos, 29 , 2 )
		tarjeta 			= Mid ( datos, 14, 10 )
		st_reloj.text 			= reloj
		st_fecha.text 			= string(fecha, "dd-mm-yyyy hh:mm")
		st_funcion.text 		= funcion
		st_incidencia.text 	= incidencia
		
		tarjeta = string(long(tarjeta))

		INSERT INTO per_fichajes (terminal, fecha, funcion, tarjeta, incidencia)
      VALUES (:reloj, :fecha, :funcion, :tarjeta, :incidencia) USING SQLCA;
		
		if SQLCA.SQLCode <> -1 then
			commit using SQLCA;
		else
			fichero_Error = FileOpen(ferror, LineMode!, Write!)
			FileWrite(fichero_Error , datos)
			fileclose(fichero_Error)
			hay_errores = true
			rollback using SQLCA;
		end if
	
	end if
loop until final = -100
fileclose(fichero)

integer li_FileNum

i = 1
fdestino = fdestino+"#"
do while FileExists(fdestino+string(i))
	i++
loop
fichero = FileCopy (forigen, fdestino+string(i), true)

if hay_Errores then
	messagebox("Información", "Importación Finalizada Con fichajes Incorrectos. ~n Consultar el fichero de errores.")
else
	messagebox("Información", "Importación Finalizada")
end if

fichero = FileCopy (forigen, forigen+'2', true)
FileDelete ( forigen )

end event

type st_1 from statictext within w_importar_fichajes
integer x = 475
integer y = 508
integer width = 306
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Reloj:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_importar_fichajes
integer x = 475
integer y = 508
integer width = 306
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Reloj:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_importar_fichajes
integer x = 475
integer y = 508
integer width = 306
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
string text = "Reloj:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_importar_fichajes
integer x = 475
integer y = 732
integer width = 306
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
string text = "Incidencia:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_importar_fichajes
integer x = 475
integer y = 656
integer width = 306
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
string text = "Función:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within w_importar_fichajes
integer x = 475
integer y = 580
integer width = 306
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
string text = "Fecha::"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_reloj from statictext within w_importar_fichajes
integer x = 818
integer y = 508
integer width = 402
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 134217752
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_fecha from statictext within w_importar_fichajes
integer x = 818
integer y = 584
integer width = 402
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 134217752
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_funcion from statictext within w_importar_fichajes
integer x = 818
integer y = 660
integer width = 402
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 134217752
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_incidencia from statictext within w_importar_fichajes
integer x = 818
integer y = 736
integer width = 402
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 134217752
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type


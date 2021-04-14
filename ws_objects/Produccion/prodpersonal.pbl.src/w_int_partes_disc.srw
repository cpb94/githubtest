$PBExportHeader$w_int_partes_disc.srw
forward
global type w_int_partes_disc from w_int_con_empresa
end type
type em_1 from u_em_campo within w_int_partes_disc
end type
type st_1 from statictext within w_int_partes_disc
end type
type cb_1 from u_boton within w_int_partes_disc
end type
type dw_1 from u_datawindow_consultas within w_int_partes_disc
end type
type st_est from statictext within w_int_partes_disc
end type
type st_2 from statictext within w_int_partes_disc
end type
type st_3 from statictext within w_int_partes_disc
end type
type st_4 from statictext within w_int_partes_disc
end type
type dw_2 from u_datawindow_consultas within w_int_partes_disc
end type
type st_esc from statictext within w_int_partes_disc
end type
type st_5 from statictext within w_int_partes_disc
end type
end forward

global type w_int_partes_disc from w_int_con_empresa
integer width = 2830
integer height = 1728
em_1 em_1
st_1 st_1
cb_1 cb_1
dw_1 dw_1
st_est st_est
st_2 st_2
st_3 st_3
st_4 st_4
dw_2 dw_2
st_esc st_esc
st_5 st_5
end type
global w_int_partes_disc w_int_partes_disc

on w_int_partes_disc.create
int iCurrent
call super::create
this.em_1=create em_1
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.st_est=create st_est
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.dw_2=create dw_2
this.st_esc=create st_esc
this.st_5=create st_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.st_est
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.dw_2
this.Control[iCurrent+10]=this.st_esc
this.Control[iCurrent+11]=this.st_5
end on

on w_int_partes_disc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.st_est)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.dw_2)
destroy(this.st_esc)
destroy(this.st_5)
end on

event open;call super::open;this.title = "Partes de asistencia desde disquette"
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_2.retrieve(codigo_empresa)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_partes_disc
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_partes_disc
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_partes_disc
end type

type em_1 from u_em_campo within w_int_partes_disc
integer x = 608
integer y = 216
integer width = 814
integer taborder = 40
boolean bringtotop = true
string text = "D:\TEMP\FICHAJES1.DBF"
end type

type st_1 from statictext within w_int_partes_disc
integer x = 334
integer y = 220
integer width = 261
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Archivo:"
boolean focusrectangle = false
end type

type cb_1 from u_boton within w_int_partes_disc
integer x = 1582
integer y = 216
integer height = 92
integer taborder = 30
boolean bringtotop = true
string text = "Procesar"
end type

event clicked;dec impor, trabajador,i,campo
dec aa,xx
dec {0}  cont
STRING registro,fichaje[], ent, sal
datetime entrada, salida,dia

// IMPORTAMOS LOS DATOS DEL ARCHIVO EN LA DATAWINDOW DW_1

impor = dw_1.Importfile(em_1.text)
IF impor<= 0 THEN
	CHOOSE CASE  impor
		CASE 0
			messagebox("Error","Archivo demasiado grande")
		CASE -2
			messagebox("Error","Archivo vacio")
		CASE -10
			messagebox("Error","Formato de archivo no valido")
		CASE -9
			messagebox("Error","Acción cancelada por el usuario")
		CASE ELSE
			messagebox("Error","Archivo no emcontrado o no valido")
		END CHOOSE
END IF

IF dw_1.rowcount() = 0 THEN
	messagebox("","El archivo no contiene datos validos")
	return
END IF

Select max(convert(int,registro)+1)
		  Into   :registro
		  From   perfichajes
		  Where  empresa = :codigo_empresa;
		  IF isnull(registro) then registro = '1'


// CARGAMOS LAS VARIABLES



st_4.text = string(impor)
FOR i= 1 to dw_1.rowcount() step 3
st_est.text = string(i)	
	trabajador 	= dec(dw_1.Getitemstring(i,"trabajador"))
	dia 			= datetime(date(dw_1.Getitemstring(i,"fecha")+"/"+string(year(today()))))
	
	cont = 0
	FOR campo = 7 to 11
		setnull(ent)
		setnull(sal)
		ent 		= dw_1.Getitemstring(i,campo)
		IF ent = '' or isnull(ent) then 
			exit
		ELSE
			cont++
			fichaje[cont] = ent
		END IF
		sal		= dw_1.Getitemstring(i+1,campo)
		IF sal = '' or isnull(sal) then 
			continue
		ELSE
			cont++
			fichaje[cont] = sal
		END IF
	NEXT
	
	
	FOR aa =1 TO cont step 2
  		st_esc.text = registro
		  entrada = datetime(date(dia),time(fichaje[aa]))
		IF aa<cont then 
			salida  = datetime(date(dia),time(fichaje[aa+1]))
		ELSE
			setnull(salida)
		END IF
		  
		  dw_2.insertrow(dec(registro))
		  dw_2.setitem(dec(registro),"empresa",codigo_empresa)	
		  dw_2.setitem(dec(registro),"dia",dia)
  		  dw_2.setitem(dec(registro),"salida",salida)
 		  dw_2.setitem(dec(registro),"entrada",entrada)
		  dw_2.setitem(dec(registro),"trabajador",trabajador)
		  dw_2.setitem(dec(registro),"registro",registro)
		  registro = string(dec(registro)+1)
	NEXT
NEXT

IF dw_2.Update()>0 THEN
	COMMIT USING sqlca;
	messagebox("","Los datos han sido guardados con éxito")
ELSE
	ROLLBACK USING sqlca;
	messagebox("","Los datos no han podido ser guardados")
END IF


end event

type dw_1 from u_datawindow_consultas within w_int_partes_disc
boolean visible = false
integer x = 2053
integer y = 188
integer width = 430
integer height = 260
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_leer_datos"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type st_est from statictext within w_int_partes_disc
integer x = 709
integer y = 1348
integer width = 251
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type st_2 from statictext within w_int_partes_disc
integer x = 169
integer y = 1352
integer width = 512
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Leyendo el registro"
boolean focusrectangle = false
end type

type st_3 from statictext within w_int_partes_disc
integer x = 969
integer y = 1344
integer width = 105
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "de"
boolean focusrectangle = false
end type

type st_4 from statictext within w_int_partes_disc
integer x = 1152
integer y = 1348
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type dw_2 from u_datawindow_consultas within w_int_partes_disc
integer x = 187
integer y = 328
integer width = 1911
integer height = 988
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_escribir_datos"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type st_esc from statictext within w_int_partes_disc
integer x = 2085
integer y = 1348
integer width = 352
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type st_5 from statictext within w_int_partes_disc
integer x = 1486
integer y = 1352
integer width = 594
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Escribiendo el registro"
boolean focusrectangle = false
end type


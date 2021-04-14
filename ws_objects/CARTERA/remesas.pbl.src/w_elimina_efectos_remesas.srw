$PBExportHeader$w_elimina_efectos_remesas.srw
$PBExportComments$incluido en w_modifica_remesas
forward
global type w_elimina_efectos_remesas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_elimina_efectos_remesas
end type
type em_banco from u_em_campo within w_elimina_efectos_remesas
end type
type st_1 from statictext within w_elimina_efectos_remesas
end type
type st_nombre_banco from statictext within w_elimina_efectos_remesas
end type
type em_remesa from u_em_campo within w_elimina_efectos_remesas
end type
type cb_consulta from commandbutton within w_elimina_efectos_remesas
end type
type st_fecha from statictext within w_elimina_efectos_remesas
end type
type em_anyorem from u_em_campo within w_elimina_efectos_remesas
end type
type st_4 from statictext within w_elimina_efectos_remesas
end type
type st_2 from statictext within w_elimina_efectos_remesas
end type
type st_3 from statictext within w_elimina_efectos_remesas
end type
type st_6 from statictext within w_elimina_efectos_remesas
end type
type st_tipodoc from statictext within w_elimina_efectos_remesas
end type
type dw_remesas from datawindow within w_elimina_efectos_remesas
end type
type dw_1 from datawindow within w_elimina_efectos_remesas
end type
type p_bandera from picture within w_elimina_efectos_remesas
end type
end forward

global type w_elimina_efectos_remesas from w_int_con_empresa
integer x = 18
integer y = 108
integer width = 2930
integer height = 2076
pb_1 pb_1
em_banco em_banco
st_1 st_1
st_nombre_banco st_nombre_banco
em_remesa em_remesa
cb_consulta cb_consulta
st_fecha st_fecha
em_anyorem em_anyorem
st_4 st_4
st_2 st_2
st_3 st_3
st_6 st_6
st_tipodoc st_tipodoc
dw_remesas dw_remesas
dw_1 dw_1
p_bandera p_bandera
end type
global w_elimina_efectos_remesas w_elimina_efectos_remesas

type variables
string filtro

integer var_ejercicio

string tipo_doc,es_nacional,situacion_efectos
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Eliminación de efectos en remesas"
This.title=istr_parametros.s_titulo_ventana

dw_remesas.SetTransObject(SQLCA)
dw_1.SetTransObject(SQLCA)

em_anyorem.text = string(year(today()))
if tipo_vista = "Nacional" then
	es_nacional = "S"
	situacion_efectos = "1"
	p_bandera.picturename = "\bmp\nacional.bmp"
else
	IF tipo_vista = "Exportacion" THEN
		es_nacional = "N"
		situacion_efectos = "6"
		p_bandera.picturename = "\bmp\export.bmp"
	ELSE
		MessageBox("ERROR","Debe seleccionar Nacional o Exportacion",Exclamation!)
		es_nacional = "X"
		p_bandera.picturename = ""
	END IF
end if
str_paramemp em
em = f_paramemp(codigo_empresa)
end event

on w_elimina_efectos_remesas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.em_banco=create em_banco
this.st_1=create st_1
this.st_nombre_banco=create st_nombre_banco
this.em_remesa=create em_remesa
this.cb_consulta=create cb_consulta
this.st_fecha=create st_fecha
this.em_anyorem=create em_anyorem
this.st_4=create st_4
this.st_2=create st_2
this.st_3=create st_3
this.st_6=create st_6
this.st_tipodoc=create st_tipodoc
this.dw_remesas=create dw_remesas
this.dw_1=create dw_1
this.p_bandera=create p_bandera
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.em_banco
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_nombre_banco
this.Control[iCurrent+5]=this.em_remesa
this.Control[iCurrent+6]=this.cb_consulta
this.Control[iCurrent+7]=this.st_fecha
this.Control[iCurrent+8]=this.em_anyorem
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_6
this.Control[iCurrent+13]=this.st_tipodoc
this.Control[iCurrent+14]=this.dw_remesas
this.Control[iCurrent+15]=this.dw_1
this.Control[iCurrent+16]=this.p_bandera
end on

on w_elimina_efectos_remesas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.em_banco)
destroy(this.st_1)
destroy(this.st_nombre_banco)
destroy(this.em_remesa)
destroy(this.cb_consulta)
destroy(this.st_fecha)
destroy(this.em_anyorem)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_6)
destroy(this.st_tipodoc)
destroy(this.dw_remesas)
destroy(this.dw_1)
destroy(this.p_bandera)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_elimina_efectos_remesas
integer x = 2377
integer y = 1352
integer width = 485
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_elimina_efectos_remesas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_elimina_efectos_remesas
integer x = 9
integer y = 4
integer width = 2427
integer height = 108
end type

type pb_1 from upb_salir within w_elimina_efectos_remesas
integer x = 2738
integer y = 4
integer width = 110
integer height = 100
integer taborder = 0
string picturename = "exit!"
end type

type em_banco from u_em_campo within w_elimina_efectos_remesas
integer x = 114
integer y = 196
integer width = 187
integer taborder = 10
long backcolor = 16777215
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION DE BANCO"
ue_datawindow ="dw_ayuda_carbancos"
ue_filtro =""

valor_empresa = TRUE
end event

event modificado;call super::modificado;st_nombre_banco.text = f_nombre_banco(codigo_empresa,em_banco.text)
end event

type st_1 from statictext within w_elimina_efectos_remesas
integer x = 110
integer y = 120
integer width = 1024
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Banco "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_nombre_banco from statictext within w_elimina_efectos_remesas
integer x = 306
integer y = 200
integer width = 818
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_remesa from u_em_campo within w_elimina_efectos_remesas
integer x = 1440
integer y = 196
integer width = 398
integer taborder = 30
integer weight = 400
fontcharset fontcharset = ansi!
long backcolor = 16777215
end type

event modified;datetime fecha_rem
dec{2}   anyo_rem,rem
string   naciextra,situacion,tiporem

dw_1.reset()

anyo_rem = dec(em_anyorem.text)

if es_nacional = "S" then
	naciextra = "N"
else
	naciextra = "E"
end if

if em_remesa.text <> "" then
	
	rem = dec(em_remesa.text)
	
	setnull(fecha_rem)
	setnull(tipo_doc)
	
	SELECT carremesas.fremesa,
			 carremesas.tipodoc,
			 carremesas.situacion,
			 carremesas.tiporem
	INTO   :fecha_rem,
			 :tipo_doc,
			 :situacion,
			 :tiporem
   FROM  carremesas
	WHERE carremesas.empresa    = :codigo_empresa
	AND	carremesas.anyo		 = :anyo_rem
	AND	carremesas.banco		 = :em_banco.text
	AND   carremesas.naci_extra = :naciextra
	AND	carremesas.remesa		 = :rem USING SQLCA;
	
	IF SQLCA.SQLCode = 100 THEN
		MessageBox("Remesas","No existe la Remesa",Exclamation!)
		em_remesa.text = ""
		f_activar_campo(em_remesa)	
	else
		if es_nacional = "S" then
			if not(situacion = "0" or situacion = "1") then
				MessageBox("Remesas","No se pueden eliminar efectos de una remesa "+f_nombre_carsiturem(codigo_empresa,situacion),Exclamation!)
				em_remesa.text = ""
				f_activar_campo(em_remesa)
			end if
		else
			if not(situacion = "0" or situacion = "1" or situacion = "2") then
				MessageBox("Remesas","No se pueden eliminar efectos de una remesa "+f_nombre_carsiturem(codigo_empresa,situacion),Exclamation!)
				em_remesa.text = ""
				f_activar_campo(em_remesa)
			end if
		end if
	END IF


	st_tipodoc.text = f_nombre_cartiporem(codigo_empresa,tiporem)
	
	if isnull(tipo_doc) then
		tipo_doc = ""
		//st_tipodoc.text = ""
	else
		//st_tipodoc.text = f_nombre_cartipodoc(codigo_empresa,string(tipo_doc))	
	end if
//	if isnull(tipo_doc) then
//		tipo_doc = ""
//		st_tipodoc.text = ""
//	else
//		st_tipodoc.text = f_nombre_cartipodoc(codigo_empresa,string(tipo_doc))	
//	end if
	
	if isnull(fecha_rem) then	
		st_fecha.visible = false	
	else
		st_fecha.visible = true
		st_fecha.text = string(date(fecha_rem))
	end if
	
	cb_consulta.TriggerEvent(clicked!)
		
end if
end event

type cb_consulta from commandbutton within w_elimina_efectos_remesas
integer x = 2537
integer y = 284
integer width = 329
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "Consultar"
end type

event clicked;int registros
registros = dw_1.retrieve(codigo_empresa,integer(em_anyorem.text),em_banco.text,integer(em_remesa.text),es_nacional,situacion_efectos)


end event

type st_fecha from statictext within w_elimina_efectos_remesas
integer x = 1838
integer y = 196
integer width = 430
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type em_anyorem from u_em_campo within w_elimina_efectos_remesas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1134
integer y = 196
integer width = 302
integer taborder = 20
long backcolor = 16777215
alignment alignment = center!
end type

event losefocus;call super::losefocus;IF em_anyorem.text = "" THEN
	f_activar_campo(em_anyorem)
END IF
end event

type st_4 from statictext within w_elimina_efectos_remesas
integer x = 1134
integer y = 120
integer width = 302
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Año"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_elimina_efectos_remesas
integer x = 1435
integer y = 120
integer width = 398
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 16711680
long backcolor = 15780518
string text = "Nº Remesa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;string naciextra,situaciones[1 to 3]

IF Trim(em_banco.text) = "" THEN f_activar_campo(em_banco)

IF Trim(em_anyorem.text) = "" THEN em_anyorem.SetFocus()

dw_1.reset()
if es_nacional = "S" then
	naciextra = "N"
	situaciones[1] = "0"
	situaciones[2] = "1"
	situaciones[3] = "1"
else
	naciextra = "E"
	situaciones[1] = "0"
	situaciones[2] = "1"
	situaciones[3] = "2"	
end if
dw_remesas.Retrieve(codigo_empresa,em_banco.text,Dec(em_anyorem.text),naciextra,situaciones)
dw_remesas.visible = TRUE
end event

type st_3 from statictext within w_elimina_efectos_remesas
integer x = 1833
integer y = 120
integer width = 439
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 65535
boolean enabled = false
string text = "Fecha Remesa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_elimina_efectos_remesas
integer x = 2272
integer y = 120
integer width = 581
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 65535
boolean enabled = false
string text = "Tipo Remesa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_tipodoc from statictext within w_elimina_efectos_remesas
integer x = 2277
integer y = 200
integer width = 571
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_remesas from datawindow within w_elimina_efectos_remesas
boolean visible = false
integer x = 1038
integer y = 120
integer width = 1499
integer height = 760
boolean bringtotop = true
string dataobject = "dw_con_simul_remesas2"
boolean livescroll = true
end type

event clicked;String tipodoc

IF row > 0 THEN
	em_remesa.text   	 = String(dw_remesas.GetItemNumber(row,"remesa"),"######")
	st_fecha.visible 	 = true
	st_fecha.text 		 = String(Date(dw_remesas.GetItemDateTime(dw_remesas.GetRow(),"fremesa")),"dd-mm-yy")
//	tipo_doc				 = dw_remesas.GetItemString(dw_remesas.GetRow(),"tipodoc")
//	tipodoc 				 = dw_remesas.GetItemString(dw_remesas.GetRow(),"tipodoc")
//	st_tipodoc.text 	 = f_nombre_cartipodoc(codigo_empresa,tipodoc)
	dw_remesas.visible = FALSE
	dw_remesas.Reset()
	
	IF em_remesa.text <> "" THEN
		cb_consulta.TriggerEvent(clicked!)
	ELSE
		f_activar_campo(em_remesa)
	END IF
else
	dw_remesas.visible = FALSE
	dw_remesas.Reset()
END IF
end event

type dw_1 from datawindow within w_elimina_efectos_remesas
integer x = 37
integer y = 296
integer width = 2496
integer height = 1560
string dataobject = "dw_borra_efectos_remesas"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;long   anyo,orden,remesa,anyo_remesa
string banco,vnacional,naciextra
dec    importe,divisas

if row > 0 then
	if f_objeto_datawindow(this) = "borrar" then
		if messagebox("Atención","¿ Desea sacar de la remesa el efecto seleccionado ?",question!,yesno!,2) = 1 then
			anyo        = this.object.anyo[row]
			orden       = this.object.orden[row]
			banco       = this.object.banco[row]
			anyo_remesa = this.object.anyo_remesa[row]
			remesa      = this.object.remesa[row]
			vnacional   = this.object.nacional[row]
			if vnacional = "S" then
				naciextra = "N"
			else
				naciextra = "E"
			end if
			importe     = this.object.importe[row]
			divisas     = this.object.divisas[row]
			update carefectos
			set    banco        = null,
			       remesa       = null,
					 fremesa      = null,
					 situacion    = "0",
					 anyo_remesa  = null,
					 remesa_total = null,
					 tipo_remesa  = null
			where  empresa      = :codigo_empresa
			and    anyo         = :anyo
			and    orden        = :orden;
			
			if sqlca.sqlcode = 0 then
				update carremesas
				set importe = importe -:importe,
				    divisas = divisas -:divisas
				where empresa    = :codigo_empresa
				and   anyo       = :anyo_remesa
				and   banco      = :banco
				and   naci_extra = :naciextra
				and   remesa     = :remesa;
				if sqlca.sqlcode = 0 then
					commit;
					cb_consulta.triggerevent(clicked!)
				else
					rollback;
					messagebox("Atención","Se ha producido un error al actualizar la remesa.")
				end if
			else
				rollback;
				messagebox("Atención","Se ha producido un error al actualizar el efecto en cartera.")
			end if
		end if
	end if
end if
end event

type p_bandera from picture within w_elimina_efectos_remesas
integer x = 27
integer y = 128
integer width = 73
integer height = 60
boolean bringtotop = true
string picturename = "c:\bmp\nacional.bmp"
boolean focusrectangle = false
end type


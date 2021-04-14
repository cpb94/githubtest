$PBExportHeader$w_con_pedidos_alb.srw
$PBExportComments$No utilizar * Seleccion lineas pedido a pasar al albarán
forward
global type w_con_pedidos_alb from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_alb
end type
type uo_proveedor from u_em_campo_2 within w_con_pedidos_alb
end type
type dw_listado_proveedores from datawindow within w_con_pedidos_alb
end type
type dw_1 from datawindow within w_con_pedidos_alb
end type
type uo_manejo from u_manejo_datawindow within w_con_pedidos_alb
end type
type pb_imprimir from upb_imprimir within w_con_pedidos_alb
end type
type gb_1 from groupbox within w_con_pedidos_alb
end type
type st_fp from statictext within w_con_pedidos_alb
end type
type cb_1 from commandbutton within w_con_pedidos_alb
end type
type cb_2 from commandbutton within w_con_pedidos_alb
end type
type st_fechaalb from statictext within w_con_pedidos_alb
end type
type st_f from statictext within w_con_pedidos_alb
end type
type st_fp_tex from statictext within w_con_pedidos_alb
end type
type st_fp_cod from statictext within w_con_pedidos_alb
end type
type gb_2 from groupbox within w_con_pedidos_alb
end type
type st_moneda from statictext within w_con_pedidos_alb
end type
type st_cod_moneda from statictext within w_con_pedidos_alb
end type
type st_desc_moneda from statictext within w_con_pedidos_alb
end type
type st_dtopp from statictext within w_con_pedidos_alb
end type
type st_dto1 from statictext within w_con_pedidos_alb
end type
type st_por_dtopp from statictext within w_con_pedidos_alb
end type
type st_por_dto1 from statictext within w_con_pedidos_alb
end type
type st_por from statictext within w_con_pedidos_alb
end type
type st_por1 from statictext within w_con_pedidos_alb
end type
end forward

shared variables
string pul='N'
end variables

global type w_con_pedidos_alb from w_int_con_empresa
integer x = 5
integer y = 288
integer width = 2949
integer height = 1660
string icon = "Application!"
pb_1 pb_1
uo_proveedor uo_proveedor
dw_listado_proveedores dw_listado_proveedores
dw_1 dw_1
uo_manejo uo_manejo
pb_imprimir pb_imprimir
gb_1 gb_1
st_fp st_fp
cb_1 cb_1
cb_2 cb_2
st_fechaalb st_fechaalb
st_f st_f
st_fp_tex st_fp_tex
st_fp_cod st_fp_cod
gb_2 gb_2
st_moneda st_moneda
st_cod_moneda st_cod_moneda
st_desc_moneda st_desc_moneda
st_dtopp st_dtopp
st_dto1 st_dto1
st_por_dtopp st_por_dtopp
st_por_dto1 st_por_dto1
st_por st_por
st_por1 st_por1
end type
global w_con_pedidos_alb w_con_pedidos_alb

type variables
string filtro
string anyo_alb,cod_alb,cod_ped,forma
string ins_pedido
str_linalbmov lin
end variables

forward prototypes
public function integer f_ultima_linea ()
public function string f_prov_alb ()
end prototypes

public function integer f_ultima_linea ();integer r
  
  SELECT max(convert(int, comlinalb.linea) )  
    INTO :r  
    FROM comlinalb  
   WHERE ( comlinalb.empresa = :codigo_empresa ) AND  
         ( comlinalb.anyo    = :anyo_alb 		  ) AND  
         ( comlinalb.albaran = :cod_alb 		  )   ;
if sqlca.sqlcode<>0 then
	messagebox("Error "+string(sqlca.sqlcode),sqlca.sqlerrtext)
	r=100
end if

return r
end function

public function string f_prov_alb ();string retorno

  SELECT comcabalb.proveedor INTO :retorno  FROM comcabalb  
  WHERE comcabalb.empresa = :codigo_empresa
  AND   comcabalb.anyo 	  = :anyo_alb
  AND   comcabalb.albaran = :cod_alb USING SQLCA;
			
IF SQLCA.SQLCode <> 0 THEN retorno = ""

RETURN retorno
	

end function

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Pedidos"
This.title=istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)

anyo_alb=string(long(istr_parametros.s_argumentos[2]))
cod_alb=istr_parametros.s_argumentos[3]
forma=istr_parametros.s_argumentos[4]



uo_proveedor.em_codigo.text = f_prov_alb()

IF Trim(uo_proveedor.em_codigo.text) = "" OR IsNull(uo_proveedor.em_codigo.text) THEN
	uo_proveedor.em_campo.setfocus()
ELSE
	uo_proveedor.triggerevent("modificado")	
END IF


end event

event ue_listar;//dw_listado_proveedores.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text,uo_proveedor.em_codigo.text,uo_proveedor.em_codigo.text)
//dw_report=dw_listado_proveedores
//CALL Super::ue_listar
end event

on w_con_pedidos_alb.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_proveedor=create uo_proveedor
this.dw_listado_proveedores=create dw_listado_proveedores
this.dw_1=create dw_1
this.uo_manejo=create uo_manejo
this.pb_imprimir=create pb_imprimir
this.gb_1=create gb_1
this.st_fp=create st_fp
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_fechaalb=create st_fechaalb
this.st_f=create st_f
this.st_fp_tex=create st_fp_tex
this.st_fp_cod=create st_fp_cod
this.gb_2=create gb_2
this.st_moneda=create st_moneda
this.st_cod_moneda=create st_cod_moneda
this.st_desc_moneda=create st_desc_moneda
this.st_dtopp=create st_dtopp
this.st_dto1=create st_dto1
this.st_por_dtopp=create st_por_dtopp
this.st_por_dto1=create st_por_dto1
this.st_por=create st_por
this.st_por1=create st_por1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_proveedor
this.Control[iCurrent+3]=this.dw_listado_proveedores
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.uo_manejo
this.Control[iCurrent+6]=this.pb_imprimir
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.st_fp
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.st_fechaalb
this.Control[iCurrent+12]=this.st_f
this.Control[iCurrent+13]=this.st_fp_tex
this.Control[iCurrent+14]=this.st_fp_cod
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.st_moneda
this.Control[iCurrent+17]=this.st_cod_moneda
this.Control[iCurrent+18]=this.st_desc_moneda
this.Control[iCurrent+19]=this.st_dtopp
this.Control[iCurrent+20]=this.st_dto1
this.Control[iCurrent+21]=this.st_por_dtopp
this.Control[iCurrent+22]=this.st_por_dto1
this.Control[iCurrent+23]=this.st_por
this.Control[iCurrent+24]=this.st_por1
end on

on w_con_pedidos_alb.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_proveedor)
destroy(this.dw_listado_proveedores)
destroy(this.dw_1)
destroy(this.uo_manejo)
destroy(this.pb_imprimir)
destroy(this.gb_1)
destroy(this.st_fp)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_fechaalb)
destroy(this.st_f)
destroy(this.st_fp_tex)
destroy(this.st_fp_cod)
destroy(this.gb_2)
destroy(this.st_moneda)
destroy(this.st_cod_moneda)
destroy(this.st_desc_moneda)
destroy(this.st_dtopp)
destroy(this.st_dto1)
destroy(this.st_por_dtopp)
destroy(this.st_por_dto1)
destroy(this.st_por)
destroy(this.st_por1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_alb
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_alb
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_proveedor.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_alb
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_pedidos_alb
integer x = 2729
integer y = 4
integer width = 123
integer height = 116
integer taborder = 0
end type

event clicked;w_mant_comlinalb.triggerevent("ue_recuperar")

close(w_con_pedidos_alb)
end event

type uo_proveedor from u_em_campo_2 within w_con_pedidos_alb
integer x = 41
integer y = 224
integer width = 1093
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_proveedor.em_campo.text=f_nombre_proveedor(codigo_empresa,uo_proveedor.em_codigo.text)
IF Trim(uo_proveedor.em_campo.text)="" THEN 
 IF Trim(uo_proveedor.em_codigo.text)<>"" Then uo_proveedor.em_campo.SetFocus()
 uo_proveedor.em_campo.text=""
 uo_proveedor.em_codigo.text=""
END IF

dw_1.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text)


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Proveedores"
ue_datawindow = "dw_ayuda_proveedores"
ue_filtro     = ""
valor_empresa = TRUE

end event

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

type dw_listado_proveedores from datawindow within w_con_pedidos_alb
boolean visible = false
integer y = 8
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_pedidos_proveedor"
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_pedidos_alb
integer y = 408
integer width = 2898
integer height = 992
string dataobject = "dw_con_pedidos_alb"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;
if isnull(dwo) then return
CHOOSE CASE dwo.name
	CASE "boton_todo"
		long i,lineas
		string pulsado,valor
		pulsado=dwo.border
		if pulsado='6' then
			dwo.border='5'
			valor="S"
		else
			dwo.border='6'
			valor="N"
		end if
		lineas=dw_1.rowcount()
		for i=1 to lineas
			dw_1.setitem(i,"libre",valor)
		next
			
	CASE "libre"
		if row=0 or isnull(row) then return
		string marcado
		marcado=dw_1.getitemstring(row,"libre")
		if marcado="S" then
			dw_1.setitem(row,"libre","N")
		else
			dw_1.setitem(row,"libre","S")
		end if
	CASE "boton_ped"
		if row=0 or isnull(row) then return
		if forma="Añadir" then 
			//
		else
			string marc,va,fp,mon
			marc=dw_1.getitemstring(row,"comcabpedpro_libre")
			if marc="S" then
				st_fp.text=""
				st_fp_cod.text=""
				st_fechaalb.text=""
				st_desc_moneda.text = ""
				st_cod_moneda.text = ""
				st_por_dtopp.text = ""
				st_por_dto1.text = ""
				va="N"
				cb_1.enabled=false
			else
				fp                  = dw_1.getitemstring(row,"comcabpedpro_forma_pago")
				st_cod_moneda.text  = dw_1.getitemstring(row,"comcabpedpro_moneda")
				st_por_dtopp.text   = String(dw_1.getitemNumber(row,"comcabpedpro_dtopp"))
				st_por_dto1.text    = String(dw_1.getitemNumber(row,"comcabpedpro_dto1"))
				st_fp.text          = f_nombre_carforpag(codigo_empresa,fp)
				st_desc_moneda.text = f_nombre_moneda(Trim(st_cod_moneda.text))
				st_fp_cod.text      = fp
				st_fechaalb.text    = String(today(),"dd-mm-yy")
				va="S"
				cb_1.enabled=true
			end if
		end if
		dw_1.setitem(row,"comcabpedpro_libre",va)
		string a,p
		long j,lini
		lini=dw_1.rowcount()
		a=dw_1.getitemstring(row,"anyo")
		p=dw_1.getitemstring(row,"pedido")
		ins_pedido=p
		for j=1 to lini
			string a1,p1
			a1=dw_1.getitemstring(j,"anyo")
			p1=dw_1.getitemstring(j,"pedido")
			if a1=a and p1=p then
				dw_1.setitem(j,"libre",va)
			end if
		next
			
		
END CHOOSE

end event

type uo_manejo from u_manejo_datawindow within w_con_pedidos_alb
event valores pbm_custom01
boolean visible = false
integer x = 1646
integer y = 100
integer width = 613
end type

event valores;call super::valores;dw_data=dw_1
f_activar_campo(uo_proveedor.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type pb_imprimir from upb_imprimir within w_con_pedidos_alb
event clicked pbm_bnclicked
boolean visible = false
integer x = 2117
integer y = 140
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
string picturename = "\bmp\print.bmp"
end type

event clicked;call super::clicked;Parent.triggerevent("ue_listar")
f_activar_campo(uo_proveedor.em_campo)
end event

type gb_1 from groupbox within w_con_pedidos_alb
integer y = 132
integer width = 1175
integer height = 240
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "Proveedor"
end type

type st_fp from statictext within w_con_pedidos_alb
integer x = 1733
integer y = 232
integer width = 549
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_con_pedidos_alb
integer x = 5
integer y = 1400
integer width = 343
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;long bien = 0
Boolean ok = TRUE
str_comcabalb cab

				// graba la cabecera en comcabalb
if forma <> "Añadir" then
	string prov,forma_pag, moneda
	datetime fecha_alb
	prov      = uo_proveedor.em_codigo.text
	fecha_alb = datetime(date(st_fechaalb.text))
	forma_pag = st_fp_cod.text
	IF (forma_pag="" or isnull(forma_pag)) then
		f_mensaje("Cabecera del Albarán","No ha pulsado sobre la M")
		return
	END IF
	cab.empresa = codigo_empresa
	cab.anyo    = anyo_alb
	cab.albaran = cod_alb
	cab.proveedor = prov
	cab.fecha_alb = fecha_alb
	cab.forma_envio = "1"
	cab.forma_pago  = forma_pag
	cab.incidencias = ""
	cab.libre		 = ""
	cab.recibido_por   = nombre_usuario
	cab.moneda      = Trim(st_cod_moneda.text)
	cab.dtopp		 = Dec(st_por_dtopp.text)
	cab.dto1			 = Dec(st_por_dto1.text)

	ok = f_insert_comcabalb(cab)
end if		  

IF ok = FALSE THEN
	bien = bien + 1
END IF
	
				// graba las lineas marcadas en comlinalb
			  
long total_lineas,i
String alm_entra,situ
str_comlinalb lal

//if forma="Añadir" then
//	linea=f_ultima_linea()
//end if
total_lineas=dw_1.rowcount()

FOR i=1 TO total_lineas
	IF dw_1.getitemstring(i,"libre") = "S" THEN
		
		string linea_alb
		string mprima,unidad,obs,pedido,linped,anyo_ped,seccion,subseccion
		string envase,descripcion
		datetime fecha
		dec cantidad,precio,quepasa
				
		lal.linea		   = "0"
		lal.empresa			= codigo_empresa
		lal.anyo				= anyo_alb
		lal.albaran			= cod_alb
		lal.mprima		   = dw_1.getitemstring(i,"comlinpedpro_mprima")
		lal.cantidad	   = dw_1.getitemnumber(i,"comlinpedpro_cantidad")
		lal.precio        = dw_1.getitemnumber(i,"comlinpedpro_precio")
		lal.fecha_entrega = dw_1.getitemdatetime(i,"comlinpedpro_fecha_entrega")
		lal.unidad_medida = dw_1.getitemstring(i,"comlinpedpro_unidad_medida")
		lal.pedido        = dw_1.getitemstring(i,"pedido")
		lal.linea_pedido  = dw_1.getitemstring(i,"comlinpedpro_linea")
		lal.observaciones = dw_1.getitemstring(i,"comlinpedpro_observaciones")
		lal.libre 			= ""
		lal.anyo_pedido	= dw_1.getitemstring(i,"anyo")
		lal.seccion			= dw_1.getitemstring(i,"comlinpedpro_seccion")
		lal.subseccion		= dw_1.getitemstring(i,"comlinpedpro_subseccion")
		lal.envase			= dw_1.getitemstring(i,"comlinpedpro_envase")
		lal.descripcion	= f_nombre_mprima(codigo_empresa,lal.mprima)
		lal.situacion 		= "N"
		lal.cuenta        = f_cuenta_mprima(codigo_empresa,lal.mprima)

		//quepasa = f_insert_comlinalb(lal)
		if quepasa = 0 then bien = bien+1
		DELETE FROM comlinpedpro  
  		WHERE ( comlinpedpro.empresa = :codigo_empresa ) AND  
        		( comlinpedpro.anyo	  = :lal.anyo_pedido) AND  
        		( comlinpedpro.pedido  = :lal.pedido) AND  
        		( comlinpedpro.linea   = :lal.linea_pedido) USING SQLCA;
		if sqlca.sqlcode<>0 then bien=bien+1
	END IF
NEXT

if bien > 0 then 
	messagebox(String(bien) + " error/es al grabar lineas en albarán","El proceso no se actualiza ~n~r"+sqlca.sqlerrtext)
	rollback;
else
	commit;
end if
dw_1.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text)
cb_2.triggerevent(clicked!)
end event

type cb_2 from commandbutton within w_con_pedidos_alb
integer x = 352
integer y = 1400
integer width = 343
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;
w_mant_comlinalb.triggerevent("ue_recuperar")

close(w_con_pedidos_alb)

end event

type st_fechaalb from statictext within w_con_pedidos_alb
integer x = 1582
integer y = 164
integer width = 357
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_f from statictext within w_con_pedidos_alb
integer x = 1221
integer y = 164
integer width = 357
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha albarán:"
boolean focusrectangle = false
end type

type st_fp_tex from statictext within w_con_pedidos_alb
integer x = 1211
integer y = 232
integer width = 425
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Forma de pago:"
boolean focusrectangle = false
end type

type st_fp_cod from statictext within w_con_pedidos_alb
integer x = 1609
integer y = 232
integer width = 114
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_con_pedidos_alb
integer x = 1189
integer y = 100
integer width = 1682
integer height = 304
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "Cabecera Albarán"
end type

type st_moneda from statictext within w_con_pedidos_alb
integer x = 1211
integer y = 316
integer width = 384
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Moneda:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_cod_moneda from statictext within w_con_pedidos_alb
integer x = 1609
integer y = 308
integer width = 114
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_desc_moneda from statictext within w_con_pedidos_alb
integer x = 1733
integer y = 308
integer width = 549
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_dtopp from statictext within w_con_pedidos_alb
integer x = 2313
integer y = 228
integer width = 265
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Dto. P.P.:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_dto1 from statictext within w_con_pedidos_alb
integer x = 2313
integer y = 308
integer width = 265
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Dto. Com.:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_por_dtopp from statictext within w_con_pedidos_alb
integer x = 2592
integer y = 228
integer width = 169
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_por_dto1 from statictext within w_con_pedidos_alb
integer x = 2592
integer y = 304
integer width = 169
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_por from statictext within w_con_pedidos_alb
integer x = 2770
integer y = 228
integer width = 55
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "%"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_por1 from statictext within w_con_pedidos_alb
integer x = 2770
integer y = 300
integer width = 55
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "%"
alignment alignment = right!
boolean focusrectangle = false
end type


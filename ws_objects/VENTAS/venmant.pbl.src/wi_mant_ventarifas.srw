$PBExportHeader$wi_mant_ventarifas.srw
$PBExportComments$Mant. de tarifas.
forward
global type wi_mant_ventarifas from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_ventarifas
end type
type dw_fechas from datawindow within wi_mant_ventarifas
end type
type cb_1 from commandbutton within wi_mant_ventarifas
end type
type st_2 from statictext within wi_mant_ventarifas
end type
type sle_porcentaje from editmask within wi_mant_ventarifas
end type
type st_4 from statictext within wi_mant_ventarifas
end type
type em_fecha from u_em_campo within wi_mant_ventarifas
end type
type r_1 from rectangle within wi_mant_ventarifas
end type
type sle_porcentaje2 from singlelineedit within wi_mant_ventarifas
end type
end forward

global type wi_mant_ventarifas from wi_mvent_con_empresa
integer width = 2871
integer height = 1536
pb_calculadora pb_calculadora
dw_fechas dw_fechas
cb_1 cb_1
st_2 st_2
sle_porcentaje sle_porcentaje
st_4 st_4
em_fecha em_fecha
r_1 r_1
sle_porcentaje2 sle_porcentaje2
end type
global wi_mant_ventarifas wi_mant_ventarifas

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
datetime fecha_activa

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control (); dw_1.Retrieve(codigo_empresa,sle_valor.Text)
 dw_fechas.Retrieve(codigo_empresa,sle_valor.text)
end subroutine

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end on

on ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "ventarifas"

f_control()

CALL Super::ue_recuperar
end on

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de tarifas"
	istr_parametros.s_listado        = "report_ventarifas"
   This.title = istr_parametros.s_titulo_ventana
   dw_fechas.SetTransObject(SQLCA)
   
  // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
   istr_parametros.i_nargumentos=0
 	IF Trim(sle_valor.text)<>"" THEN
		 This.TriggerEvent("ue_recuperar")
		 Return
	END IF
END IF


end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

on wi_mant_ventarifas.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_fechas=create dw_fechas
this.cb_1=create cb_1
this.st_2=create st_2
this.sle_porcentaje=create sle_porcentaje
this.st_4=create st_4
this.em_fecha=create em_fecha
this.r_1=create r_1
this.sle_porcentaje2=create sle_porcentaje2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_fechas
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.sle_porcentaje
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.em_fecha
this.Control[iCurrent+8]=this.r_1
this.Control[iCurrent+9]=this.sle_porcentaje2
end on

on wi_mant_ventarifas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_fechas)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.sle_porcentaje)
destroy(this.st_4)
destroy(this.em_fecha)
destroy(this.r_1)
destroy(this.sle_porcentaje2)
end on

event ue_actualiza_dw;call super::ue_actualiza_dw;long total_filas
datetime fecha

dw_fechas.Retrieve(codigo_empresa,sle_valor.text)

fecha = dw_1.object.activa[dw_1.getrow()]
select count (*)
into :total_filas
from venmapatarifas
where empresa = :codigo_empresa
and tarifa = :sle_valor.text;

if total_filas = 0 then
	insert into venmapatarifas (empresa, tarifa, fecha, usuario)
	values (:codigo_empresa, :sle_valor.text, :fecha, :nombre_usuario);
end if

if SQLCA.SQLCode = 0 then
	CALL Super::ue_actualiza_dw
end if
end event

event ue_borra_fila;call super::ue_borra_fila;
DELETE FROM venmapatarifas  
WHERE (venmapatarifas.empresa  = :codigo_empresa)
AND   (venmapatarifas.tarifa   = :sle_valor.text );
  
DELETE FROM venlintarifas  
WHERE (venlintarifas.empresa = :codigo_empresa ) AND  
      (venlintarifas.tarifa  = :sle_valor.text )   ;

DELETE FROM ventarfamfor  
WHERE (ventarfamfor.empresa = :codigo_empresa ) AND  
      (ventarfamfor.tarifa  = :sle_valor.text )   ;

Delete From venmapatarifas_idiomas
Where   venmapatarifas_idiomas.empresa = :codigo_empresa
And     venmapatarifas_idiomas.tarifa  = :sle_valor.text
And     venmapatarifas_idiomas.fecha   = :fecha_activa;

COMMIT;


end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_ventarifas
integer x = 133
integer y = 320
integer width = 1874
integer height = 432
integer taborder = 20
string dataobject = "dw_ventarifas"
end type

event dw_1::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "moneda"
		 valor_empresa = FALSE
      bus_titulo     = "VENTANA SELECCION DE MONEDAS "
 		bus_datawindow = "dw_ayuda_divisas"

 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_ventarifas"
CHOOSE CASE ls_objeto
  
CASE 'pb_moneda'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"moneda")
   OpenWithParm(wi_mant_divisas,lstr_param)  

END CHOOSE





end event

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;f_valores_numericos(dw_1,"moneda")

end on

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "moneda"
 	   valor_empresa = FALSE
      bus_titulo     = "VENTANA SELECCION DE MONEDAS"
      bus_datawindow = "dw_ayuda_divisas"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

event dw_1::itemchanged;call super::itemchanged;

if dwo.name = 'moneda' then
	this.object.decimales_precios[row] = f_decimales_precios_moneda(data)
end if
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_ventarifas
integer x = 82
integer y = 196
integer width = 315
string text = "Tárifa"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_ventarifas
integer x = 1536
integer y = 188
end type

event cb_insertar::clicked;datetime fecha,fecha1 
String  tarifa,empresa,valor

IF cb_insertar.enabled= TRUE THEN

	valor = String(dw_1.GetItemDatetime(dw_1.GetRow(),"activa"))
   IF valor = "00-00-00" or isnull(valor) then
		 dw_1.SetItem(dw_1.GetRow(),"activa",datetime(today()))
	end if
    
  dw_1.AcceptText()
/*    valor = String(dw_1.GetItemDatetime(dw_1.GetRow(),"activa"))
    IF valor<>"00-00-00" then
   	  IF IsNull(valor) Then
          MessageBox("Tarifa no definida en el mapa","No existe la tarifa a esa fecha ",Exclamation!, OK!,1)
          dw_1.SetColumn("activa")
          dw_1.SetFocus()
          RETURN
        END IF

        fecha = dw_1.GetItemDatetime(dw_1.GetRow(),"activa")
        empresa = codigo_empresa
        tarifa  = sle_valor.text

		  SELECT venmapatarifas.f_alta  
			 INTO :fecha1  
			 FROM venmapatarifas  
			WHERE ( venmapatarifas.empresa = :empresa ) AND  
					( venmapatarifas.tarifa = :tarifa ) AND  
					( venmapatarifas.fecha = :fecha )   ;
		  IF SQLCA.SQLCODE =100   THEN
				MessageBox("Tarifa no definida en el mapa","No existe la tarifa a esa fecha ",Exclamation!, OK!,1)
				dw_1.SetColumn("activa")
				dw_1.SetFocus()
				RETURN
		  END IF
		END IF*/
   END IF

CALL Super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_ventarifas
integer x = 1947
integer y = 188
end type

event cb_borrar::clicked;Integer reg
Select Count(*) Into :reg From venclientes
Where  venclientes.empresa = :codigo_empresa
And    venclientes.tarifa  = :sle_valor.text;
IF IsNull(reg) Then reg = 0
IF reg <> 0 Then
	f_mensaje("Existen clientes asignados a esta tarifa"," No se puede borrar el registro")
	Return
END IF	
IF sle_valor.text = f_tarifa_venparametros(codigo_empresa) Then
	f_mensaje("Esta tarifa no se puede borrar","Esta tarifa esta parametrizada como tarifa base ")
	Return
END IF	

fecha_activa = dw_1.GetItemDatetime(dw_1.GetRow(),"activa")

CALL Super::clicked

end event

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_ventarifas
integer x = 407
integer y = 192
end type

event sle_valor::getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_ventarifas"
   ue_titulo         = "AYUDA SELECCION DE TARIFAS"
   ue_filtro         = ""
   isle_campo        = This
	
	f_control()
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_ventarifas
integer x = 2359
integer y = 188
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_ventarifas
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_ventarifas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_ventarifas
integer width = 2757
end type

type pb_calculadora from u_calculadora within wi_mant_ventarifas
integer x = 672
integer y = 192
integer taborder = 0
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From ventarifas
 Where  ventarifas.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,ventarifas.codigo)+1)
  Into   :sle_valor.text
  From   ventarifas
  Where  ventarifas.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end on

type dw_fechas from datawindow within wi_mant_ventarifas
integer x = 2016
integer y = 376
integer width = 741
integer height = 448
boolean bringtotop = true
boolean titlebar = true
string title = "Relación de fechas"
string dataobject = "dw_ventarifas1"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;/*
IF cb_insertar.enabled=TRUE Then
 dw_1.SetFocus()
 Return
END IF

str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_ventarifas"
CHOOSE CASE f_objeto_datawindow(This)
  
CASE 'pb_carpeta'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]  = sle_valor.text
   lstr_param.s_argumentos[3]  = String(today())
   OpenWithParm(wi_mant_venmapatarifas,lstr_param)  

END CHOOSE

IF Getrow() = 0 Then Return

IF dwo.name = "fecha_1"  Then 
 dw_1.TriggerEvent(Clicked!)
 dw_1.SetItem(dw_1.GetRow(),"activa",This.GetItemDateTime(row,"fecha_1"))
 cb_insertar.TriggerEvent("Clicked")
END IF	
*/


end event

type cb_1 from commandbutton within wi_mant_ventarifas
integer x = 1349
integer y = 1048
integer width = 553
integer height = 196
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar Tarifa"
end type

event clicked;dec porcentaje
string sel
datastore datos
long i
string articulo
boolean exito



if sle_porcentaje.text <> '' and sle_valor.text <> '' AND em_fecha.text <> '' then
	if MessageBox("Atención", "Esta operación modificará todos los precios de los artículos dados de alta antes de esa fecha y asignados a esta tarifa.~t ~r "+&
						"¿Desea continuar?", Exclamation!, YesNo!, 2) = 1 then
		porcentaje = dec (sle_porcentaje.text)				
		
		
		sel = " select articulos.codigo "+&
				" from articulos, venlintarifas "+&
				" where venlintarifas.tarifa = '"+sle_valor.text+"' "+&
				" and articulos.fecha_alta <= '"+em_fecha.text+"' "+&
				" and articulos.empresa = '"+codigo_empresa+"' "+&
				" and articulos.empresa = venlintarifas.empresa "+&
				" and articulos.codigo = venlintarifas.articulo"
				
		f_cargar_cursor_nuevo (sel, datos)
		exito = true
		for i = 1 to datos.rowcount()
			articulo = datos.object.articulos_codigo[i]
			connect using SQLCA;
			update venlintarifas
			set precio  = round (precio + ((precio * :porcentaje) / 100 ), 2 )
			where empresa = :codigo_empresa
			and tarifa = :sle_valor.text
			and articulo = :articulo;

			if SQLCA.SQLCode = -1 THEN 
				exito = false
			end if
			f_mensaje_proceso ("Regs:",i, datos.rowcount())
		next
		
		if exito then
			commit using SQLCA;
			messagebox ("Atención", "Proceso finalizado sin errores. ")			
		else
			rollback using SQLCA;
			messagebox ("Atención", "Se produjo un error, no se actualizará la tarifa. ")			
		end if
		
	end if	
else
	messagebox ("Atención", "Debe rellenar los campos TARIFA , PORCENTAJE y FECHA ")
end if

destroy datos

/*
dec porcentaje
if sle_porcentaje.text <> '' and sle_valor.text <> '' then
	if MessageBox("Atención", "Esta operación modificará todos los precios asignados a esta tarifa.~t ~r "+&
						"¿Desea continuar?", Exclamation!, YesNo!, 2) = 1 then
		porcentaje = dec (sle_porcentaje.text)				
		connect using SQLCA;
		update venlintarifas
		set precio  = round (precio + ((precio * :porcentaje) / 100 ), 2 )
		where empresa = :codigo_empresa
		and tarifa = :sle_valor.text;
		
		if SQLCA.SQLCode = -1 THEN 
        MessageBox("SQL error", SQLCA.SQLErrText)
		  rollback using SQLCA;
		else
			commit using SQLCA;
	      MessageBox("Información", "Actualización de tarifa realizada con éxito.")
		end if
	end if	
else
	messagebox ("Atención", "Debe rellenar los campos TARIFA y PORCENTAJE")
end if
*/
end event

type st_2 from statictext within wi_mant_ventarifas
integer x = 197
integer y = 1056
integer width = 805
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33471187
string text = "Porcentaje a aplicar a la tarifa:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_porcentaje from editmask within wi_mant_ventarifas
integer x = 1001
integer y = 1052
integer width = 192
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
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###.00"
end type

type st_4 from statictext within wi_mant_ventarifas
integer x = 183
integer y = 1160
integer width = 805
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33471187
string text = "Fecha Alta Artículo <="
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within wi_mant_ventarifas
integer x = 1001
integer y = 1144
integer width = 293
integer height = 80
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type r_1 from rectangle within wi_mant_ventarifas
integer linethickness = 4
long fillcolor = 33471187
integer x = 178
integer y = 1032
integer width = 1751
integer height = 228
end type

type sle_porcentaje2 from singlelineedit within wi_mant_ventarifas
integer x = 1710
integer y = 1116
integer width = 174
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
end type


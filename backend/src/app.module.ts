// src/app.module.ts
import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';  // ConfigModule をインポート
import { ItemsModule } from './items/items.module';  // 他のモジュール（既存の）
import { PgClientModule } from './common/pg-client/pg-client.module';  // PgClientModule をインポート

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,  // 環境変数をアプリケーション全体で利用可能にする設定
      envFilePath: '.env',  // .env ファイルを指定（デフォルトでプロジェクトのルートディレクトリ）
    }),
    ItemsModule,  // 他のモジュール（既存のもの）
    PgClientModule,  // PgClientModule をインポート
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}



// src/common/pg-client/pg-client.module.ts
import { Module, Global } from '@nestjs/common';
import { Client } from 'pg';

@Global()
@Module({
  providers: [
    {
      provide: 'PG_CLIENT',
      useFactory: () => {
        const client = new Client({
          host: process.env.DATABASE_HOST,
          port: parseInt(process.env.DATABASE_PORT, 10),
          user: process.env.DATABASE_USER,
          password: process.env.DATABASE_PASSWORD,
          database: process.env.DATABASE_NAME,
        });
        client.connect();
        return client;
      },
    },
  ],
  exports: ['PG_CLIENT'],
})
export class PgClientModule {}
